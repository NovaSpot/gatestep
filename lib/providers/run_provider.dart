import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../models/run_session.dart';

/// Number of consecutive unrealistic GPS fixes before we assume
/// GPS has re-acquired at a new location and use that point as
/// a new anchor without adding the jump to the distance.
const int _maxConsecutiveJumpRejections = 3;

/// Minimum distance that must be travelled between accepted GPS points.
///
/// Small GPS fluctuations below this value are ignored.
const double _minMovementMeters = 3.0;

/// Maximum GPS accuracy allowed for the initial GPS fix.
///
/// The first fix is allowed to be slightly weaker so that the
/// tracker can establish its starting position.
const double _initialMaxAccuracy = 25.0;

/// Maximum GPS accuracy allowed for subsequent tracking points.
///
/// Once tracking has started, we require a better GPS signal
/// before using a point for distance calculation.
const double _maxAcceptableAccuracy = 15.0;

/// Maximum physically reasonable running speed.
///
/// 12 m/s = 43.2 km/h.
///
/// This is deliberately generous and is mainly used to detect
/// GPS teleportation/jumps rather than normal running speed.
const double _maxReasonableSpeed = 12.0;

/// If no valid movement has been detected for this long,
/// moving time stops increasing.
const Duration _stationaryThreshold = Duration(seconds: 5);

final runProvider = NotifierProvider<RunNotifier, RunSession>(() {
  return RunNotifier();
});

class RunNotifier extends Notifier<RunSession> {
  Timer? _elapsedTimer;
  Timer? _movingTimer;

  StreamSubscription<Position>? _positionStream;

  Position? _lastPosition;

  DateTime? _lastMovementTime;

  int _consecutiveJumpRejections = 0;

  bool _gpsActive = false;

  @override
  RunSession build() {
    // Make sure timers and GPS streams never outlive
    // the notifier.
    ref.onDispose(_cancelAllTimersAndStreams);

    return RunSession.initial();
  }

  // ============================================================
  // START RUN
  // ============================================================

  void startRun({
    required double targetDistance,
  }) {
    // Don't start another run if one is already active.
    if (state.isActive) return;

    // Clean up anything left from a previous run.
    _cancelAllTimersAndStreams();

    // Start a completely fresh session.
    state = RunSession.initial().copyWith(
      targetDistance: targetDistance,
      isActive: true,
      startTime: DateTime.now(),
      gpsStatus: GpsStatus.syncing,
    );

    // Reset GPS tracking state.
    _lastPosition = null;
    _lastMovementTime = null;
    _consecutiveJumpRejections = 0;

    // Start elapsed time.
    _startElapsedTimer();

    // Start GPS.
    _startLocationTracking();
  }

  // ============================================================
  // ELAPSED TIME
  // ============================================================

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();

    _elapsedTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!state.isActive) return;

        state = state.copyWith(
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      },
    );
  }

  // ============================================================
  // MOVING TIME
  // ============================================================

  void _startMovingTimer() {
    _movingTimer?.cancel();

    _movingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!state.isActive || !_gpsActive) {
          return;
        }

        // Only count this second as moving if a valid movement
        // was recorded recently.
        final hasRecentMovement =
            _lastMovementTime != null &&
            DateTime.now().difference(
                  _lastMovementTime!,
                ) <=
                _stationaryThreshold;

        if (hasRecentMovement) {
          state = state.copyWith(
            movingTimeSeconds:
                state.movingTimeSeconds + 1,
          );
        }
      },
    );
  }

  // ============================================================
  // START GPS TRACKING
  // ============================================================

  Future<void> _startLocationTracking() async {
    // ----------------------------------------------------------
    // Check location service
    // ----------------------------------------------------------

    final serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _gpsActive = false;

      state = state.copyWith(
        gpsStatus: GpsStatus.disabled,
      );

      return;
    }

    // ----------------------------------------------------------
    // Check permission
    // ----------------------------------------------------------

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        _gpsActive = false;

        state = state.copyWith(
          gpsStatus: GpsStatus.denied,
        );

        return;
      }
    }

    if (permission ==
        LocationPermission.deniedForever) {
      _gpsActive = false;

      state = state.copyWith(
        gpsStatus: GpsStatus.denied,
      );

      return;
    }

    // The run may have been paused/stopped while
    // permission dialog was open.
    if (!state.isActive) {
      return;
    }

    // Don't create duplicate streams.
    if (_positionStream != null) {
      return;
    }

    state = state.copyWith(
      gpsStatus: GpsStatus.synced,
    );

    _gpsActive = true;

    _startMovingTimer();

    // ----------------------------------------------------------
    // GPS STREAM
    // ----------------------------------------------------------

    _positionStream =
        Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,

        // Request a new GPS position after approximately
        // 3 meters of movement.
        distanceFilter: 3,
      ),
    ).listen(
      _onPosition,

      onError: (error) {
        // GPS stream has failed.
        _gpsActive = false;

        // IMPORTANT:
        //
        // Clear the subscription so a future retry can
        // actually create a new stream.
        _positionStream?.cancel();
        _positionStream = null;

        state = state.copyWith(
          gpsStatus: GpsStatus.disabled,
        );
      },
    );
  }

  // ============================================================
  // HANDLE GPS POSITION
  // ============================================================

  void _onPosition(Position position) {
    // Ignore GPS updates when the run isn't active.
    if (!state.isActive || !_gpsActive) {
      return;
    }

    // ==========================================================
    // 1. FIRST GPS FIX
    // ==========================================================

    if (_lastPosition == null) {
      // Allow a slightly weaker initial GPS fix.
      if (position.accuracy <= 0 ||
          position.accuracy >
              _initialMaxAccuracy) {
        return;
      }

      // Establish the initial GPS anchor.
      _lastPosition = position;

      // Add initial point to route.
      state = state.copyWith(
        routePoints: [
          ...state.routePoints,
          {
            'lat': position.latitude,
            'lng': position.longitude,
          },
        ],
      );

      // IMPORTANT:
      //
      // Do NOT set _lastMovementTime here.
      //
      // Receiving the first GPS position does not mean
      // the user is moving.
      return;
    }

    // ==========================================================
    // 2. SUBSEQUENT GPS ACCURACY FILTER
    // ==========================================================

    if (position.accuracy <= 0 ||
        position.accuracy >
            _maxAcceptableAccuracy) {
      return;
    }

    // ==========================================================
    // 3. CALCULATE DISTANCE
    // ==========================================================

    final distanceInMeters =
        Geolocator.distanceBetween(
      _lastPosition!.latitude,
      _lastPosition!.longitude,
      position.latitude,
      position.longitude,
    );

    // ==========================================================
    // 4. IGNORE GPS JITTER
    // ==========================================================

    if (distanceInMeters <
        _minMovementMeters) {
      return;
    }

    // ==========================================================
    // 5. CALCULATE TIME BETWEEN GPS FIXES
    // ==========================================================

    final timeDifference =
        position.timestamp.difference(
      _lastPosition!.timestamp,
    );

    final timeMilliseconds =
        timeDifference.inMilliseconds;

    // ----------------------------------------------------------
    // Handle invalid/out-of-order timestamps.
    // ----------------------------------------------------------

    if (timeMilliseconds <= 0) {
      _consecutiveJumpRejections++;

      // If repeated bad timestamps occur, use the current
      // position as a new anchor without adding distance.
      if (_consecutiveJumpRejections >=
          _maxConsecutiveJumpRejections) {
        _lastPosition = position;
        _consecutiveJumpRejections = 0;
      }

      return;
    }

    final seconds =
        timeMilliseconds / 1000.0;

    // ==========================================================
    // 6. CALCULATE APPARENT SPEED
    // ==========================================================

    final calculatedSpeed =
        distanceInMeters / seconds;

    // ==========================================================
    // 7. DETECT IMPOSSIBLE GPS JUMP
    // ==========================================================

    if (calculatedSpeed >
        _maxReasonableSpeed) {
      _consecutiveJumpRejections++;

      // Repeated unrealistic positions usually mean
      // GPS has re-acquired somewhere else.
      if (_consecutiveJumpRejections >=
          _maxConsecutiveJumpRejections) {
        // Re-anchor WITHOUT adding the jump to distance.
        _lastPosition = position;

        _consecutiveJumpRejections = 0;
      }

      return;
    }

    // ==========================================================
    // VALID MOVEMENT
    // ==========================================================

    _consecutiveJumpRejections = 0;

    // ==========================================================
    // 8. ADD DISTANCE
    // ==========================================================

    final addedDistanceKM =
        distanceInMeters / 1000.0;

    final newDistance =
        state.currentDistance +
        addedDistanceKM;

    // ==========================================================
    // 9. RECORD MOVEMENT
    // ==========================================================

    _lastMovementTime = DateTime.now();

    // ==========================================================
    // 10. CALCULATE PACE
    // ==========================================================

    double currentPace = 0;

    if (newDistance > 0 &&
        state.movingTimeSeconds > 0) {
      // seconds per kilometer
      currentPace =
          state.movingTimeSeconds /
              newDistance;
    }

    // ==========================================================
    // 11. ADD ROUTE POINT
    // ==========================================================

    final updatedRoute = [
      ...state.routePoints,
      {
        'lat': position.latitude,
        'lng': position.longitude,
      },
    ];

    // ==========================================================
    // 12. UPDATE STATE
    // ==========================================================

    state = state.copyWith(
      currentDistance: newDistance,
      currentPace: currentPace,
      routePoints: updatedRoute,
    );

    // ==========================================================
    // 13. UPDATE GPS ANCHOR
    // ==========================================================

    // Only update the anchor after accepting this GPS point.
    _lastPosition = position;
  }

  // ============================================================
  // PAUSE RUN
  // ============================================================

  void pauseRun() {
    if (!state.isActive) return;

    state = state.copyWith(
      isActive: false,
    );

    _pauseTrackingResources();
  }

  void _pauseTrackingResources() {
    _gpsActive = false;

    // Stop elapsed timer.
    _elapsedTimer?.cancel();
    _elapsedTimer = null;

    // Stop moving timer.
    _movingTimer?.cancel();
    _movingTimer = null;

    // Stop GPS stream.
    _positionStream?.cancel();
    _positionStream = null;

    // IMPORTANT:
    //
    // Drop the GPS anchor so movement while paused
    // is never added to the run after resume.
    _lastPosition = null;

    _lastMovementTime = null;

    _consecutiveJumpRejections = 0;
  }

  // ============================================================
  // RESUME RUN
  // ============================================================

  void resumeRun() {
    if (state.isActive) return;

    state = state.copyWith(
      isActive: true,
      gpsStatus: GpsStatus.syncing,
    );

    // Start elapsed timer again.
    _startElapsedTimer();

    // Re-check GPS service/permissions and create
    // a fresh GPS stream.
    _startLocationTracking();
  }

  // ============================================================
  // STOP RUN
  // ============================================================

  RunSession stopRun() {
    // IMPORTANT:
    //
    // Save the completed run before clearing resources.
    final completedRun = state.copyWith(
      isActive: false,
    );

    _cancelAllTimersAndStreams();

    // Keep completed data in Riverpod state so that
    // RunCompleteScreen / RankUpScreen can read it.
    state = completedRun;

    return completedRun;
  }

  // ============================================================
  // CLEANUP
  // ============================================================

  void _cancelAllTimersAndStreams() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;

    _movingTimer?.cancel();
    _movingTimer = null;

    _positionStream?.cancel();
    _positionStream = null;

    _lastPosition = null;

    _lastMovementTime = null;

    _consecutiveJumpRejections = 0;

    _gpsActive = false;
  }
}
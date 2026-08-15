import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../models/run_session.dart';

final runProvider = NotifierProvider<RunNotifier, RunSession>(() {
  return RunNotifier();
});

class RunNotifier extends Notifier<RunSession> {
  Timer? _timer;
  Timer? _movingTimer;
  StreamSubscription<Position>? _positionStream;
  Position? _lastPosition;
  bool _gpsActive = false;

  @override
  RunSession build() {
    return RunSession.initial();
  }

  void startRun({required double targetDistance}) {
    state = RunSession.initial().copyWith(
      targetDistance: targetDistance,
      isActive: true,
      startTime: DateTime.now(),
      gpsStatus: GpsStatus.syncing,
    );
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isActive) {
        state = state.copyWith(
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      }
    });

    _startLocationTracking();
  }

  Future<void> _startLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = state.copyWith(gpsStatus: GpsStatus.disabled);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = state.copyWith(gpsStatus: GpsStatus.denied);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = state.copyWith(gpsStatus: GpsStatus.denied);
      return;
    }

    state = state.copyWith(gpsStatus: GpsStatus.synced);
    _gpsActive = true;

    _movingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isActive && _gpsActive) {
        state = state.copyWith(
          movingTimeSeconds: state.movingTimeSeconds + 1,
        );
      }
    });

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // 5 meters
      ),
    ).listen((Position position) {
      if (!state.isActive) return;

      final newPoint = {'lat': position.latitude, 'lng': position.longitude};
      final updatedRoute = [...state.routePoints, newPoint];

      if (_lastPosition != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        double addedDistanceKM = distanceInMeters / 1000;
        double newDistance = state.currentDistance + addedDistanceKM;

        // Calculate pace using moving time (seconds per KM)
        double currentPace = 0;
        if (newDistance > 0 && state.movingTimeSeconds > 0) {
           currentPace = state.movingTimeSeconds / newDistance; 
        }

        state = state.copyWith(
          currentDistance: newDistance,
          currentPace: currentPace,
          routePoints: updatedRoute,
        );
      } else {
        state = state.copyWith(
          routePoints: updatedRoute,
        );
      }
      _lastPosition = position;
    });

  }

  void stopRun() {
    _gpsActive = false;
    state = state.copyWith(isActive: false);
    _timer?.cancel();
    _movingTimer?.cancel();
    _positionStream?.cancel();
    _lastPosition = null;
  }
}

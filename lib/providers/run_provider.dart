import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../models/run_session.dart';

final runProvider = NotifierProvider<RunNotifier, RunSession>(() {
  return RunNotifier();
});

class RunNotifier extends Notifier<RunSession> {
  Timer? _timer;
  StreamSubscription<Position>? _positionStream;
  Position? _lastPosition;

  @override
  RunSession build() {
    return RunSession.initial();
  }

  void startRun({required double targetDistance}) {
    state = RunSession.initial().copyWith(
      targetDistance: targetDistance,
      isActive: true,
      startTime: DateTime.now(),
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
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // 10 meters
      ),
    ).listen((Position position) {
      if (!state.isActive) return;

      if (_lastPosition != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        double addedDistanceKM = distanceInMeters / 1000;
        double newDistance = state.currentDistance + addedDistanceKM;

        // Calculate pace (minutes per km)
        double currentPace = 0;
        if (newDistance > 0) {
           // pace in seconds per KM
           currentPace = state.elapsedSeconds / newDistance; 
        }

        state = state.copyWith(
          currentDistance: newDistance,
          currentPace: currentPace,
        );
      }
      _lastPosition = position;
    });
  }

  void stopRun() {
    state = state.copyWith(isActive: false);
    _timer?.cancel();
    _positionStream?.cancel();
    _lastPosition = null;
  }
}

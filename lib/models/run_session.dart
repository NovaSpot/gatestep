enum GpsStatus { initial, syncing, synced, denied, disabled }

class RunSession {
  final double targetDistance;
  final double currentDistance;
  final DateTime? startTime;
  final int elapsedSeconds;
  final int movingTimeSeconds;
  final bool isActive;
  final double currentPace; // seconds per KM
  final List<Map<String, double>> routePoints;
  final GpsStatus gpsStatus;

  const RunSession({
    required this.targetDistance,
    required this.currentDistance,
    this.startTime,
    required this.elapsedSeconds,
    required this.movingTimeSeconds,
    required this.isActive,
    required this.currentPace,
    this.routePoints = const [],
    this.gpsStatus = GpsStatus.initial,
  });

  factory RunSession.initial() {
    return const RunSession(
      targetDistance: 5.0,
      currentDistance: 0.0,
      startTime: null,
      elapsedSeconds: 0,
      movingTimeSeconds: 0,
      isActive: false,
      currentPace: 0.0,
      routePoints: [],
      gpsStatus: GpsStatus.initial,
    );
  }

  RunSession copyWith({
    double? targetDistance,
    double? currentDistance,
    DateTime? startTime,
    int? elapsedSeconds,
    int? movingTimeSeconds,
    bool? isActive,
    double? currentPace,
    List<Map<String, double>>? routePoints,
    GpsStatus? gpsStatus,
  }) {
    return RunSession(
      targetDistance: targetDistance ?? this.targetDistance,
      currentDistance: currentDistance ?? this.currentDistance,
      startTime: startTime ?? this.startTime,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      movingTimeSeconds: movingTimeSeconds ?? this.movingTimeSeconds,
      isActive: isActive ?? this.isActive,
      currentPace: currentPace ?? this.currentPace,
      routePoints: routePoints ?? this.routePoints,
      gpsStatus: gpsStatus ?? this.gpsStatus,
    );
  }
}

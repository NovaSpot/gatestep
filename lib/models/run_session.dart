class RunSession {
  final double targetDistance;
  final double currentDistance;
  final DateTime? startTime;
  final int elapsedSeconds;
  final bool isActive;
  final double currentPace; // seconds per KM

  const RunSession({
    required this.targetDistance,
    required this.currentDistance,
    this.startTime,
    required this.elapsedSeconds,
    required this.isActive,
    required this.currentPace,
  });

  factory RunSession.initial() {
    return const RunSession(
      targetDistance: 5.0,
      currentDistance: 0.0,
      startTime: null,
      elapsedSeconds: 0,
      isActive: false,
      currentPace: 0.0,
    );
  }

  RunSession copyWith({
    double? targetDistance,
    double? currentDistance,
    DateTime? startTime,
    int? elapsedSeconds,
    bool? isActive,
    double? currentPace,
  }) {
    return RunSession(
      targetDistance: targetDistance ?? this.targetDistance,
      currentDistance: currentDistance ?? this.currentDistance,
      startTime: startTime ?? this.startTime,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isActive: isActive ?? this.isActive,
      currentPace: currentPace ?? this.currentPace,
    );
  }
}

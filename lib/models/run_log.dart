class RunLog {
  final String id;
  final DateTime timestamp;
  final int elapsedSeconds;
  final double distance;
  final int xpEarned;

  const RunLog({
    required this.id,
    required this.timestamp,
    required this.elapsedSeconds,
    required this.distance,
    required this.xpEarned,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'elapsedSeconds': elapsedSeconds,
      'distance': distance,
      'xpEarned': xpEarned,
    };
  }

  factory RunLog.fromJson(Map<String, dynamic> json) {
    return RunLog(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      elapsedSeconds: json['elapsedSeconds'] as int,
      distance: (json['distance'] as num).toDouble(),
      xpEarned: json['xpEarned'] as int,
    );
  }
}
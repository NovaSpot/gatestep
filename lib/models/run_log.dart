class RunLog {
  final String id;
  final DateTime timestamp;
  final int elapsedSeconds;
  final double distance;
  final int xpEarned;
  final List<Map<String, double>> routePoints;

  const RunLog({
    required this.id,
    required this.timestamp,
    required this.elapsedSeconds,
    required this.distance,
    required this.xpEarned,
    this.routePoints = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'elapsedSeconds': elapsedSeconds,
      'distance': distance,
      'xpEarned': xpEarned,
      'routePoints': routePoints,
    };
  }

  factory RunLog.fromJson(Map<String, dynamic> json) {
    List<Map<String, double>> parsedRoutePoints = [];
    if (json['routePoints'] != null) {
      final rawList = json['routePoints'] as List<dynamic>;
      parsedRoutePoints = rawList.map((pt) {
        final m = pt as Map<String, dynamic>;
        return {
          'lat': (m['lat'] as num).toDouble(),
          'lng': (m['lng'] as num).toDouble(),
        };
      }).toList();
    }

    return RunLog(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      elapsedSeconds: json['elapsedSeconds'] as int,
      distance: (json['distance'] as num).toDouble(),
      xpEarned: json['xpEarned'] as int,
      routePoints: parsedRoutePoints,
    );
  }
}
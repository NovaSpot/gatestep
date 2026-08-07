class Quest {
  final String id;
  final String title;
  final double targetDistance;
  final double currentDistance;
  final int xpReward;
  final bool isCompleted;

  const Quest({
    required this.id,
    required this.title,
    required this.targetDistance,
    required this.currentDistance,
    required this.xpReward,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'targetDistance': targetDistance,
      'currentDistance': currentDistance,
      'xpReward': xpReward,
      'isCompleted': isCompleted,
    };
  }

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'] as String,
      title: json['title'] as String,
      targetDistance: (json['targetDistance'] as num).toDouble(),
      currentDistance: (json['currentDistance'] as num).toDouble(),
      xpReward: json['xpReward'] as int,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Quest copyWith({
    String? id,
    String? title,
    double? targetDistance,
    double? currentDistance,
    int? xpReward,
    bool? isCompleted,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      targetDistance: targetDistance ?? this.targetDistance,
      currentDistance: currentDistance ?? this.currentDistance,
      xpReward: xpReward ?? this.xpReward,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

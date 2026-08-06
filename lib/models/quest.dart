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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quest.dart';

final questsProvider = NotifierProvider<QuestsNotifier, List<Quest>>(() {
  return QuestsNotifier();
});

class QuestsNotifier extends Notifier<List<Quest>> {
  @override
  List<Quest> build() {
    return [
      const Quest(
        id: 'q1',
        title: 'DAILY WARMUP',
        targetDistance: 3.0,
        currentDistance: 0.0,
        xpReward: 500,
        isCompleted: false,
      ),
      const Quest(
        id: 'q2',
        title: 'HUNTER TRAINING',
        targetDistance: 5.0,
        currentDistance: 0.0,
        xpReward: 1200,
        isCompleted: false,
      ),
      const Quest(
        id: 'q3',
        title: 'ENDURANCE TEST',
        targetDistance: 10.0,
        currentDistance: 0.0,
        xpReward: 3000,
        isCompleted: false,
      ),
    ];
  }

  int updateProgress(double distanceAdded) {
    int totalXpEarned = 0;
    
    state = state.map((quest) {
      if (quest.isCompleted) return quest;

      double newDistance = quest.currentDistance + distanceAdded;
      bool completedNow = newDistance >= quest.targetDistance;

      if (completedNow) {
        totalXpEarned += quest.xpReward;
      }

      return quest.copyWith(
        currentDistance: newDistance,
        isCompleted: completedNow,
      );
    }).toList();

    return totalXpEarned;
  }
}

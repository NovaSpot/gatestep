import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gatestep/providers/hunter_provider.dart';
import 'package:gatestep/providers/quests_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('updateProgress completes quests and returns their XP', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final xpEarned = container.read(questsProvider.notifier).updateProgress(5.0);

    expect(xpEarned, 1700); // q1 (500) + q2 (1200) complete, q3 (10km) not
    final quests = container.read(questsProvider);
    expect(quests[0].isCompleted, true);
    expect(quests[1].isCompleted, true);
    expect(quests[2].isCompleted, false);
    expect(quests[2].currentDistance, 5.0);
  });

  test('addRunStats combines base XP with quest bonus XP', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(hunterProvider.notifier).addRunStats(2.0, 600, bonusXp: 500);

    final hunter = container.read(hunterProvider);
    expect(hunter.xp, 0); // 2500 XP crossed both 1000 and 1500 thresholds
    expect(hunter.level, 3);
    expect(hunter.totalDistance, 2.0);
    expect(hunter.clearedGates, 1);
  });
}
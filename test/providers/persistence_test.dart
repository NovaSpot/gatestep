import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gatestep/models/run_log.dart';
import 'package:gatestep/providers/hunter_provider.dart';
import 'package:gatestep/providers/quests_provider.dart';
import 'package:gatestep/providers/run_logs_provider.dart';

final mayRunTimestamp = DateTime(2042, 11, 22);
final _todayStr = DateTime.now().toIso8601String().split('T').first;

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'quests_last_reset_date': _todayStr,
    });
  });

  test('hunter profile persists across provider recreation', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(hunterProvider.notifier).addRunStats(2.0, 600);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final restarted = ProviderContainer();
    addTearDown(restarted.dispose);
    restarted.read(hunterProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final loaded = restarted.read(hunterProvider);
    expect(loaded.totalDistance, 2.0);
    expect(loaded.totalTimeSeconds, 600);
    expect(loaded.level, 2);
    expect(loaded.xp, 1000);
  });

  test('quest progress persists across provider recreation', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(questsProvider.notifier).updateProgress(4.0);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final restarted = ProviderContainer();
    addTearDown(restarted.dispose);
    restarted.read(questsProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final loaded = restarted.read(questsProvider);
    expect(loaded[0].isCompleted, true);
    expect(loaded[1].currentDistance, 4.0);
  });

  test('run log persists across provider recreation', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(runLogsProvider.notifier).addLog(RunLog(
          id: 'LOG_1',
          timestamp: mayRunTimestamp,
          elapsedSeconds: 600,
          distance: 5.0,
          xpEarned: 5000,
          routePoints: [
            {'lat': 35.6762, 'lng': 139.6503},
            {'lat': 35.6770, 'lng': 139.6510},
          ],
        ));
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final restarted = ProviderContainer();
    addTearDown(restarted.dispose);
    restarted.read(runLogsProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final loaded = restarted.read(runLogsProvider);
    expect(loaded.length, 1);
    expect(loaded.first.id, 'LOG_1');
    expect(loaded.first.distance, 5.0);
    expect(loaded.first.xpEarned, 5000);
    expect(loaded.first.routePoints.length, 2);
    expect(loaded.first.routePoints.first['lat'], 35.6762);
  });
}
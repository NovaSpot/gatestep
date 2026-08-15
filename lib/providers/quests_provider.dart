import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quest.dart';

final questsProvider = NotifierProvider<QuestsNotifier, List<Quest>>(() {
  return QuestsNotifier();
});

class QuestsNotifier extends Notifier<List<Quest>> {
  static const _storageKey = 'quests';
  static const _dateKey = 'quests_last_reset_date';
  bool _loaded = false;

  @override
  List<Quest> build() {
    _load();
    return _defaultQuests();
  }

  List<Quest> _defaultQuests() {
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

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      final lastResetStr = prefs.getString(_dateKey);
      final today = DateTime.now().toIso8601String().split('T').first;

      bool shouldReset = lastResetStr != today;

      if (shouldReset) {
        await _resetQuests(prefs);
        return;
      }

      if (raw != null && !_loaded) {
        _loaded = true;
        final decoded = jsonDecode(raw) as List<dynamic>;
        state = decoded
            .map((e) => Quest.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      // Ignore corrupted/missing persisted data and use defaults.
    }
  }

  Future<void> _resetQuests(SharedPreferences prefs) async {
    final defaults = _defaultQuests();
    state = defaults;
    await prefs.setString(_storageKey, jsonEncode(defaults.map((q) => q.toJson()).toList()));
    await prefs.setString(_dateKey, DateTime.now().toIso8601String().split('T').first);
    _loaded = true;
  }

  Future<void> _save() async {
    _loaded = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(state.map((q) => q.toJson()).toList()),
    );
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

    _save();

    return totalXpEarned;
  }
}
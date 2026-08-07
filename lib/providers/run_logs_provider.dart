import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/run_log.dart';

final runLogsProvider = NotifierProvider<RunLogsNotifier, List<RunLog>>(() {
  return RunLogsNotifier();
});

class RunLogsNotifier extends Notifier<List<RunLog>> {
  static const _storageKey = 'run_logs';
  bool _loaded = false;

  @override
  List<RunLog> build() {
    _load();
    return const [];
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw != null && !_loaded) {
        _loaded = true;
        final decoded = jsonDecode(raw) as List<dynamic>;
        state = decoded
            .map((e) => RunLog.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      // Ignore corrupted/missing persisted data and use defaults.
    }
  }

  Future<void> _save() async {
    _loaded = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(state.map((log) => log.toJson()).toList()),
    );
  }

  void addLog(RunLog log) {
    state = [log, ...state];
    _save();
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hunter_profile.dart';

final hunterProvider = NotifierProvider<HunterNotifier, HunterProfile>(() {
  return HunterNotifier();
});

class HunterNotifier extends Notifier<HunterProfile> {
  @override
  HunterProfile build() {
    return HunterProfile.initial();
  }

  void addRunStats(double distance, int timeSeconds) {
    int xpEarned = (distance * 1000).toInt(); // 1000 XP per KM
    
    // Add time/distance stats
    double newTotalDistance = state.totalDistance + distance;
    int newTotalTime = state.totalTimeSeconds + timeSeconds;
    int newClearedGates = state.clearedGates + 1;
    
    // Handle level up logic
    int newXp = state.xp + xpEarned;
    int newLevel = state.level;
    int newXpToNextLevel = state.xpToNextLevel;
    String newRank = state.rank;
    int earnedStatPoints = 0;
    
    while (newXp >= newXpToNextLevel) {
      newXp -= newXpToNextLevel;
      newLevel++;
      earnedStatPoints += 3;
      newXpToNextLevel = (newXpToNextLevel * 1.5).toInt();
    }
    
    // Simple rank calculation based on level
    if (newLevel >= 50) newRank = 'S';
    else if (newLevel >= 40) newRank = 'A';
    else if (newLevel >= 30) newRank = 'B';
    else if (newLevel >= 20) newRank = 'C';
    else if (newLevel >= 10) newRank = 'D';

    state = state.copyWith(
      xp: newXp,
      level: newLevel,
      xpToNextLevel: newXpToNextLevel,
      rank: newRank,
      totalDistance: newTotalDistance,
      totalTimeSeconds: newTotalTime,
      clearedGates: newClearedGates,
      statPoints: state.statPoints + earnedStatPoints,
    );
  }

  void allocateStat(String statType) {
    if (state.statPoints <= 0) return;

    if (statType == 'STR') {
      state = state.copyWith(
        strength: state.strength + 1,
        statPoints: state.statPoints - 1,
      );
    } else if (statType == 'AGI') {
      state = state.copyWith(
        agility: state.agility + 1,
        statPoints: state.statPoints - 1,
      );
    } else if (statType == 'VIT') {
      state = state.copyWith(
        vitality: state.vitality + 1,
        statPoints: state.statPoints - 1,
      );
    }
  }
}

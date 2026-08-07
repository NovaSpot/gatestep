class HunterProfile {
  final String codename;
  final String rank;
  final int level;
  final int xp;
  final int xpToNextLevel;
  final double totalDistance; // in KM
  final int totalTimeSeconds; // in seconds
  final int clearedGates;
  final int statPoints;
  final int strength;
  final int agility;
  final int vitality;

  const HunterProfile({
    required this.codename,
    required this.rank,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.totalDistance,
    required this.totalTimeSeconds,
    required this.clearedGates,
    required this.statPoints,
    required this.strength,
    required this.agility,
    required this.vitality,
  });

  factory HunterProfile.initial() {
    return const HunterProfile(
      codename: 'RONAN ABRAHAM',
      rank: 'E',
      level: 1,
      xp: 0,
      xpToNextLevel: 1000,
      totalDistance: 0.0,
      totalTimeSeconds: 0,
      clearedGates: 0,
      statPoints: 0,
      strength: 10,
      agility: 10,
      vitality: 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codename': codename,
      'rank': rank,
      'level': level,
      'xp': xp,
      'xpToNextLevel': xpToNextLevel,
      'totalDistance': totalDistance,
      'totalTimeSeconds': totalTimeSeconds,
      'clearedGates': clearedGates,
      'statPoints': statPoints,
      'strength': strength,
      'agility': agility,
      'vitality': vitality,
    };
  }

  factory HunterProfile.fromJson(Map<String, dynamic> json) {
    return HunterProfile(
      codename: json['codename'] as String? ?? 'RONAN ABRAHAM',
      rank: json['rank'] as String? ?? 'E',
      level: json['level'] as int? ?? 1,
      xp: json['xp'] as int? ?? 0,
      xpToNextLevel: json['xpToNextLevel'] as int? ?? 1000,
      totalDistance: (json['totalDistance'] as num?)?.toDouble() ?? 0.0,
      totalTimeSeconds: json['totalTimeSeconds'] as int? ?? 0,
      clearedGates: json['clearedGates'] as int? ?? 0,
      statPoints: json['statPoints'] as int? ?? 0,
      strength: json['strength'] as int? ?? 10,
      agility: json['agility'] as int? ?? 10,
      vitality: json['vitality'] as int? ?? 10,
    );
  }

  HunterProfile copyWith({
    String? codename,
    String? rank,
    int? level,
    int? xp,
    int? xpToNextLevel,
    double? totalDistance,
    int? totalTimeSeconds,
    int? clearedGates,
    int? statPoints,
    int? strength,
    int? agility,
    int? vitality,
  }) {
    return HunterProfile(
      codename: codename ?? this.codename,
      rank: rank ?? this.rank,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      totalDistance: totalDistance ?? this.totalDistance,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
      clearedGates: clearedGates ?? this.clearedGates,
      statPoints: statPoints ?? this.statPoints,
      strength: strength ?? this.strength,
      agility: agility ?? this.agility,
      vitality: vitality ?? this.vitality,
    );
  }
}

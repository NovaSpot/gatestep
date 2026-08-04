import 'package:flutter/material.dart';

class AppColors {
  // Core backgrounds
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceLight = Color(0xFF1C2333);

  // Accents
  static const Color primaryCyan = Color(0xFF00FFD1);
  static const Color secondaryCyan = Color(0xFF7DF9FF);
  static const Color accentTeal = Color(0xFF00BFA5);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF4A5568);

  // Tier borders
  static const Color sTierGold = Color(0xFFFFD700);
  static const Color aTierCyan = Color(0xFF00FFD1);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color xpGreen = Color(0xFF00E676);

  // Gradient
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF00FFD1), Color(0xFF7DF9FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF0D1117), Color(0xFF161B22)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

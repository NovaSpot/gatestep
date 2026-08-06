import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hunter_provider.dart';

class HunterProfileScreen extends ConsumerWidget {
  const HunterProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hunter = ref.watch(hunterProvider);
    double xpProgress = hunter.xp / hunter.xpToNextLevel;
    int hours = hunter.totalTimeSeconds ~/ 3600;
    
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            // Header
            Text(
              'HUNTER PROFILE',
              style: GoogleFonts.shareTechMono(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'SYSTEM_OS // ARCHIVE_ACCESS_GRANTED',
              style: GoogleFonts.shareTechMono(
                color: AppColors.textSecondary,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Avatar
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryCyan.withAlpha(80), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryCyan.withAlpha(20),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/hunter_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceLight,
                        child: Icon(Icons.person, size: 80, color: AppColors.primaryCyan.withAlpha(60)),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Name
            Center(
              child: Column(
                children: [
                  Text(
                    'CODENAME',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hunter.codename,
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Rank Progress
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.textSecondary.withAlpha(60)),
                  ),
                  child: Text(
                    'RANK_${hunter.rank}',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: (xpProgress * 100).toInt().clamp(0, 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryCyan,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Expanded(flex: (100 - (xpProgress * 100).toInt()).clamp(0, 100), child: const SizedBox()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'XP: ${hunter.xp}/${hunter.xpToNextLevel}',
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            if (hunter.statPoints > 0) ...[
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryCyan.withAlpha(20),
                    border: Border.all(color: AppColors.primaryCyan),
                  ),
                  child: Text(
                    'AVAILABLE STAT POINTS: ${hunter.statPoints}',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.primaryCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 40),
            // Tactical Attributes
            Row(
              children: [
                Icon(Icons.video_label, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 8),
                Text(
                  'TACTICAL ATTRIBUTES',
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAttributeCard('STR', hunter.strength.toString(), 'LVL', Icons.fitness_center, ref, hunter.statPoints > 0)),
                const SizedBox(width: 16),
                Expanded(child: _buildAttributeCard('AGI', hunter.agility.toString(), 'LVL', Icons.speed, ref, hunter.statPoints > 0)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAttributeCard('VIT', hunter.vitality.toString(), 'LVL', Icons.favorite_border, ref, hunter.statPoints > 0)),
                const SizedBox(width: 16),
                Expanded(child: Container()), // Empty placeholder for symmetry
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeCard(String label, String value, String unit, IconData icon, WidgetRef ref, bool canAllocate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.textSecondary.withAlpha(30)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.shareTechMono(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              Icon(icon, color: AppColors.textSecondary.withAlpha(150), size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              if (canAllocate)
                InkWell(
                  onTap: () {
                    ref.read(hunterProvider.notifier).allocateStat(label);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryCyan.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.primaryCyan),
                    ),
                    child: const Icon(Icons.add, color: AppColors.primaryCyan, size: 16),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

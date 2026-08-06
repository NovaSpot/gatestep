import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/cyber_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hunter_provider.dart';
import '../providers/quests_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hunter = ref.watch(hunterProvider);
    final quests = ref.watch(questsProvider);
    
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Character avatar
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.textSecondary.withAlpha(60),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryCyan.withAlpha(20),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  'assets/images/avatar_home.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.surfaceLight,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: AppColors.primaryCyan.withAlpha(60),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Stats row 1
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'TOTAL_XP',
                    value: hunter.xp.toString(),
                    unit: 'XP',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    label: 'GATES_CLEARED',
                    value: hunter.clearedGates.toString().padLeft(2, '0'),
                    unit: 'GTS',
                    valueColor: AppColors.primaryCyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Stats row 2
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'DISTANCE',
                    value: hunter.totalDistance.toStringAsFixed(1),
                    unit: 'KM',
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 32),
            // Start Hunting button
            CyberButton(
              text: 'START HUNTING',
              icon: Icons.shield_outlined,
              onPressed: () {
                Navigator.pushNamed(context, '/setDistance');
              },
            ),
            const SizedBox(height: 40),
            // Daily Quests Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SYSTEM_QUESTS // DAILY',
                style: GoogleFonts.shareTechMono(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...quests.map((quest) {
              double progress = (quest.currentDistance / quest.targetDistance).clamp(0.0, 1.0);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(
                    color: quest.isCompleted ? AppColors.primaryCyan : AppColors.textSecondary.withAlpha(30),
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          quest.title,
                          style: GoogleFonts.shareTechMono(
                            color: quest.isCompleted ? AppColors.primaryCyan : AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${quest.xpReward} XP',
                          style: GoogleFonts.shareTechMono(
                            color: AppColors.sTierGold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: (progress * 100).toInt(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: quest.isCompleted ? AppColors.primaryCyan : AppColors.textSecondary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: (100 - (progress * 100).toInt()),
                                  child: const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${quest.currentDistance.toStringAsFixed(1)}/${quest.targetDistance.toStringAsFixed(1)} KM',
                          style: GoogleFonts.shareTechMono(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

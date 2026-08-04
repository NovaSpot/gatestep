import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_card.dart';

class HunterProfileScreen extends StatelessWidget {
  const HunterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'RONAN ABRAHAM',
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
                    'RANK_E',
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
                              flex: 65,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryCyan,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const Expanded(flex: 35, child: SizedBox()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'XP: 650/1000',
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
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
                Expanded(child: _buildAttributeCard('STR', '42.8', 'KM', Icons.fitness_center, 0.4)),
                const SizedBox(width: 16),
                Expanded(child: _buildAttributeCard('AGI', '05:42', 'PACE', Icons.speed, 0.7)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAttributeCard('DURATION', '184', 'HRS', Icons.timer_outlined, 0.5)),
                const SizedBox(width: 16),
                Expanded(child: _buildAttributeCard('SYNC', '24', 'GATES', Icons.hub_outlined, 0.8)),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeCard(String label, String value, String unit, IconData icon, double progress) {
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
          const SizedBox(height: 12),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: (progress * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
                Expanded(
                  flex: ((1 - progress) * 100).toInt(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

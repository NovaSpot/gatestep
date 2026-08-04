import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/tier_section.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
              'ACHIEVEMENTS',
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
            // S-Tier Section
            TierSection(
              tierName: 'S_TIER',
              borderColor: AppColors.sTierGold,
              characters: const [
                CharacterCard(
                  name: 'AEON',
                  id: '001',
                  imagePath: 'assets/images/char_aeon.png',
                  borderColor: AppColors.sTierGold,
                ),
                CharacterCard(
                  name: 'SAITAMA',
                  id: '004',
                  imagePath: 'assets/images/char_punch.png',
                  borderColor: AppColors.sTierGold,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // A-Tier Section
            TierSection(
              tierName: 'A_TIER',
              borderColor: AppColors.aTierCyan,
              characters: const [
                CharacterCard(
                  name: 'GOJO',
                  id: '022',
                  imagePath: 'assets/images/char_blind.png',
                  borderColor: AppColors.aTierCyan,
                ),
                CharacterCard(
                  name: 'NARUTO',
                  id: '045',
                  imagePath: 'assets/images/char_ninja.png',
                  borderColor: AppColors.aTierCyan,
                ),
                CharacterCard(
                  name: 'LUFFY',
                  id: '089',
                  imagePath: 'assets/images/char_pirate.png',
                  borderColor: AppColors.aTierCyan,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

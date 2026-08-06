import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hunter_provider.dart';
import '../providers/run_provider.dart';

class RankUpScreen extends ConsumerWidget {
  const RankUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runSession = ref.watch(runProvider);
    final hunter = ref.watch(hunterProvider);
    
    int xpEarned = (runSession.currentDistance * 1000).toInt();
    
    final int hours = runSession.elapsedSeconds ~/ 3600;
    final int minutes = (runSession.elapsedSeconds % 3600) ~/ 60;
    final int seconds = runSession.elapsedSeconds % 60;
    String timeString = '${hours > 0 ? '$hours:' : ''}${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Gold gradient top
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.sTierGold.withAlpha(180),
                    AppColors.sTierGold.withAlpha(80),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'GATE CLEARED',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.background.withAlpha(180),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  Text(
                    'RANK UP',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.sTierGold,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: AppColors.sTierGold.withAlpha(100),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Character Card large
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryCyan.withAlpha(80)),
                      color: AppColors.surface,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/char_fighter.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person, size: 100, color: AppColors.textSecondary);
                          },
                        ),
                        // Overlay gradients
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.background.withAlpha(200),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                        // Logo top left
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Row(
                            children: [
                              const Icon(Icons.shield_outlined, color: AppColors.primaryCyan, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                'GATESTEP',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.primaryCyan,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Version top right
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textSecondary.withAlpha(60)),
                            ),
                            child: Text(
                              '[V1.0]',
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        // Name bottom left
                        Positioned(
                          bottom: 24,
                          left: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '> HUNTER_ID',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                hunter.codename,
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rank badge bottom right
                        Positioned(
                          bottom: 24,
                          right: 24,
                          child: Column(
                            children: [
                              Text(
                                hunter.rank,
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.sTierGold,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(color: AppColors.sTierGold.withAlpha(100), blurRadius: 10),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.sTierGold),
                                ),
                                child: Text(
                                  'RANK',
                                  style: GoogleFonts.shareTechMono(
                                    color: AppColors.sTierGold,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // XP Calculation
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.textSecondary.withAlpha(40)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calculate_outlined, color: AppColors.textSecondary, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '[EXPERIENCE_CALCULATION]',
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildCalculationRow('Base XP = Distance x 1000', '$xpEarned', AppColors.sTierGold),
                        const SizedBox(height: 12),
                        _buildCalculationRow('Total XP Yield', '$xpEarned XP', AppColors.primaryCyan, isTotal: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Stats row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.textSecondary.withAlpha(40)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DISTANCE', style: GoogleFonts.shareTechMono(color: AppColors.textSecondary, fontSize: 10, letterSpacing: 1.5)),
                              const SizedBox(height: 4),
                              Text('${runSession.currentDistance.toStringAsFixed(2)} KM', style: GoogleFonts.shareTechMono(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.textSecondary.withAlpha(40)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('TIME', style: GoogleFonts.shareTechMono(color: AppColors.textSecondary, fontSize: 10, letterSpacing: 1.5)),
                              const SizedBox(height: 4),
                              Text(timeString, style: GoogleFonts.shareTechMono(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CyberButton(
                    text: 'GO TO HOME',
                    isSuccess: true,
                    onPressed: () {
                      ref.read(hunterProvider.notifier).addRunStats(
                        runSession.currentDistance, 
                        runSession.elapsedSeconds
                      );
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationRow(String label, String value, Color valueColor, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.shareTechMono(
            color: isTotal ? AppColors.primaryCyan : AppColors.textPrimary,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            color: valueColor,
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

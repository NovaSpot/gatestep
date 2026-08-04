import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';
import '../widgets/map_preview.dart';
import '../widgets/timer_display.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TRACKING',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.my_location, color: AppColors.primaryCyan, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'SYNCED',
                        style: GoogleFonts.shareTechMono(
                          color: AppColors.primaryCyan,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Timer
              const TimerDisplay(
                hours: '00',
                minutes: '14',
                seconds: '32',
              ),
              const SizedBox(height: 24),
              // Stats
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.primaryCyan.withAlpha(40)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DISTANCE_TRK',
                          style: GoogleFonts.shareTechMono(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '2.4',
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' / 5.0 KM',
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Progress bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryCyan,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.secondaryCyan.withAlpha(100),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Expanded(flex: 52, child: SizedBox()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Pace
                    Container(
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: AppColors.textSecondary.withAlpha(60))),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PACE_AVG',
                            style: GoogleFonts.shareTechMono(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '06:05',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.primaryCyan,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '/KM',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.primaryCyan.withAlpha(150),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Map preview
              const Expanded(
                child: MapPreview(label: 'PREVIEW // TERRITORY'),
              ),
              const SizedBox(height: 24),
              CyberButton(
                text: '× CANCEL RUN',
                isDanger: true,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/runComplete');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

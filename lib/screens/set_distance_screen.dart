import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';
import '../widgets/map_preview.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/run_provider.dart';

class SetDistanceScreen extends ConsumerStatefulWidget {
  const SetDistanceScreen({super.key});

  @override
  ConsumerState<SetDistanceScreen> createState() => _SetDistanceScreenState();
}

class _SetDistanceScreenState extends ConsumerState<SetDistanceScreen> {
  double _distance = 5.0;

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
                children: [
                  Icon(Icons.radar, color: AppColors.textSecondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'MISSION PARAMETERS',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'SET DISTANCE',
                style: GoogleFonts.shareTechMono(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Calibrate target distance for route generation.',
                style: GoogleFonts.shareTechMono(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              // Input Distance Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.primaryCyan.withAlpha(40)),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    // Badge
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        color: AppColors.primaryCyan.withAlpha(20),
                        child: Text(
                          'INPUT // DISTANCE',
                          style: GoogleFonts.shareTechMono(
                            color: AppColors.primaryCyan,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'TARGET DISTANCE',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.textSecondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    _distance.toStringAsFixed(1),
                                    style: GoogleFonts.shareTechMono(
                                      color: AppColors.textPrimary,
                                      fontSize: 48,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'KM',
                                    style: GoogleFonts.shareTechMono(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Slider
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primaryCyan,
                              inactiveTrackColor: AppColors.primaryCyan.withAlpha(30),
                              thumbColor: AppColors.primaryCyan,
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 0),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                            ),
                            child: Slider(
                              value: _distance,
                              min: 1.0,
                              max: 20.0,
                              divisions: 190,
                              onChanged: (val) {
                                setState(() {
                                  _distance = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1.0 KM',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '20.0 KM',
                                style: GoogleFonts.shareTechMono(
                                  color: AppColors.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Presets
                          Row(
                            children: [
                              Expanded(child: _buildPresetButton('3K', 3.0)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildPresetButton('5K', 5.0)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildPresetButton('10K', 10.0)),
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
                text: 'START RUN',
                isPrimary: true,
                onPressed: () {
                  ref.read(runProvider.notifier).startRun(targetDistance: _distance);
                  Navigator.pushReplacementNamed(context, '/tracking');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresetButton(String label, double value) {
    final isSelected = _distance == value;
    return InkWell(
      onTap: () {
        setState(() {
          _distance = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryCyan.withAlpha(20) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.textSecondary.withAlpha(60),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.shareTechMono(
            color: isSelected ? AppColors.primaryCyan : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

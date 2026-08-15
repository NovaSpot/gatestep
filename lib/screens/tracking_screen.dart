import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';
import '../widgets/map_preview.dart';
import '../widgets/timer_display.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/run_provider.dart';
import '../models/run_session.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runSession = ref.watch(runProvider);

    // Listen for run completion
    ref.listen<RunSession>(runProvider, (previous, next) {
      if (previous != null && 
          previous.isActive && 
          next.isActive && 
          next.currentDistance >= next.targetDistance) {
        ref.read(runProvider.notifier).stopRun();
        Navigator.pushReplacementNamed(context, '/runComplete');
      }
    });

    final int hours = runSession.elapsedSeconds ~/ 3600;
    final int minutes = (runSession.elapsedSeconds % 3600) ~/ 60;
    final int seconds = runSession.elapsedSeconds % 60;
    
    final paceMins = (runSession.currentPace ~/ 60).toString().padLeft(2, '0');
    final paceSecs = (runSession.currentPace % 60).toInt().toString().padLeft(2, '0');

    // Handle GPS status
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (runSession.gpsStatus) {
      case GpsStatus.syncing:
        statusColor = AppColors.secondaryCyan;
        statusText = 'SYNCING...';
        statusIcon = Icons.gps_not_fixed;
        break;
      case GpsStatus.synced:
        statusColor = AppColors.primaryCyan;
        statusText = 'SYNCED';
        statusIcon = Icons.my_location;
        break;
      case GpsStatus.denied:
        statusColor = AppColors.danger;
        statusText = 'PERMISSION DENIED';
        statusIcon = Icons.location_off;
        break;
      case GpsStatus.disabled:
        statusColor = AppColors.danger;
        statusText = 'GPS DISABLED';
        statusIcon = Icons.gps_off;
        break;
      default:
        statusColor = AppColors.textSecondary;
        statusText = 'INITIALIZING...';
        statusIcon = Icons.gps_not_fixed;
    }

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
                      Icon(statusIcon, color: statusColor, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        statusText,
                        style: GoogleFonts.shareTechMono(
                          color: statusColor,
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
              TimerDisplay(
                hours: hours.toString().padLeft(2, '0'),
                minutes: minutes.toString().padLeft(2, '0'),
                seconds: seconds.toString().padLeft(2, '0'),
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
                              runSession.currentDistance.toStringAsFixed(2),
                              style: GoogleFonts.shareTechMono(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' / ${runSession.targetDistance.toStringAsFixed(1)} KM',
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
                            flex: (runSession.currentDistance / runSession.targetDistance * 100).toInt().clamp(0, 100),
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
                          Expanded(flex: (100 - (runSession.currentDistance / runSession.targetDistance * 100).toInt()).clamp(0, 100), child: const SizedBox()),
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
                                '$paceMins:$paceSecs',
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
              // GPS error message
              if (runSession.gpsStatus == GpsStatus.denied || runSession.gpsStatus == GpsStatus.disabled)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withAlpha(30),
                    border: Border.all(color: AppColors.danger),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        runSession.gpsStatus == GpsStatus.denied 
                            ? 'LOCATION PERMISSION REQUIRED' 
                            : 'ENABLE GPS IN SETTINGS',
                        style: GoogleFonts.shareTechMono(
                          color: AppColors.danger,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        runSession.gpsStatus == GpsStatus.denied
                            ? 'Grant location permission in app settings to track your run.'
                            : 'Turn on location services in device settings.',
                        style: GoogleFonts.shareTechMono(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              // Map preview
              Expanded(
                child: MapPreview(
                  label: 'LIVE // GPS TRACK',
                  routePoints: runSession.routePoints,
                ),
              ),
              const SizedBox(height: 24),
              CyberButton(
                text: '× CANCEL RUN',
                isDanger: true,
                onPressed: () {
                  ref.read(runProvider.notifier).stopRun();
                  Navigator.pushReplacementNamed(context, '/main');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

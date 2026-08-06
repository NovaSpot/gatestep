import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';
import '../widgets/timer_display.dart';
import '../widgets/map_preview.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/run_provider.dart';

class RunCompleteScreen extends ConsumerWidget {
  const RunCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runSession = ref.watch(runProvider);
    final int hours = runSession.elapsedSeconds ~/ 3600;
    final int minutes = (runSession.elapsedSeconds % 3600) ~/ 60;
    final int seconds = runSession.elapsedSeconds % 60;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'CUSAT → SOE',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TimerDisplay(
                    hours: hours.toString().padLeft(2, '0'),
                    minutes: minutes.toString().padLeft(2, '0'),
                    seconds: seconds.toString().padLeft(2, '0'),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: MapPreview(
                label: null,
                showCoordinates: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CyberButton(
                text: 'COMPLETED',
                isSuccess: true,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/rankUp');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

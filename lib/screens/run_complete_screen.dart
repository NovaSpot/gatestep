import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';
import '../widgets/timer_display.dart';
import '../widgets/map_preview.dart';

class RunCompleteScreen extends StatelessWidget {
  const RunCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const TimerDisplay(
                    hours: '00',
                    minutes: '14',
                    seconds: '32',
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

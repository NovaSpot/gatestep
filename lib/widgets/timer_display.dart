import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class TimerDisplay extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;

  const TimerDisplay({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.primaryCyan.withAlpha(60), width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'SYS.CLOCK_T',
              style: GoogleFonts.shareTechMono(
                color: AppColors.textSecondary,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryCyan.withAlpha(100), width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDigitPair(hours),
                _buildSeparator(),
                _buildDigitPair(minutes),
                _buildSeparator(),
                _buildDigitPair(seconds),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ELAPSED_TIME',
            style: GoogleFonts.shareTechMono(
              color: AppColors.textSecondary,
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitPair(String digits) {
    return Text(
      digits,
      style: GoogleFonts.shareTechMono(
        color: AppColors.primaryCyan,
        fontSize: 52,
        fontWeight: FontWeight.w300,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: GoogleFonts.shareTechMono(
          color: AppColors.primaryCyan.withAlpha(150),
          fontSize: 48,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

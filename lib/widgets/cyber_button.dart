import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CyberButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isPrimary;
  final bool isDanger;
  final bool isSuccess;
  final double? width;

  const CyberButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.isDanger = false,
    this.isSuccess = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    if (isDanger) {
      bgColor = const Color(0xFFFFB4AB);
      textColor = Colors.black;
      borderColor = AppColors.danger;
    } else if (isSuccess) {
      bgColor = const Color(0xFF6B8E23);
      textColor = Colors.white;
      borderColor = AppColors.success;
    } else if (isPrimary) {
      bgColor = AppColors.secondaryCyan.withAlpha(220);
      textColor = Colors.black;
      borderColor = AppColors.primaryCyan;
    } else {
      bgColor = Colors.transparent;
      textColor = AppColors.textSecondary;
      borderColor = AppColors.textMuted;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor, size: 20),
                  const SizedBox(width: 12),
                ],
                Text(
                  text,
                  style: GoogleFonts.shareTechMono(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

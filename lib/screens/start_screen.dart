import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/start_bg.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: AppColors.background);
            },
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background.withAlpha(100),
                  AppColors.background.withAlpha(200),
                  AppColors.background,
                ],
                stops: const [0.0, 0.4, 0.6, 0.85],
              ),
            ),
          ),
          // Top gradient for title
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  AppColors.background.withAlpha(180),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Title
                  Text(
                    'GATESTEP',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.primaryCyan,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      shadows: [
                        Shadow(
                          color: AppColors.primaryCyan.withAlpha(100),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withAlpha(180),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryCyan.withAlpha(40),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryCyan,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SYSTEM_OS // AWAKENING',
                          style: GoogleFonts.shareTechMono(
                            color: AppColors.primaryCyan,
                            fontSize: 11,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Tagline
                  Text(
                    'EVERY STEP OPENS A\nGATE',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Enter Dungeon button
                  CyberButton(
                    text: 'ENTER DUNGEON',
                    icon: Icons.menu_book_outlined,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                  ),
                  const SizedBox(height: 12),
                  // Settings button
                  CyberButton(
                    text: 'SETTINGS',
                    icon: Icons.settings,
                    isPrimary: false,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                  // Footer
                  Center(
                    child: Text(
                      '[ SYS.LATENCY: 12ms ]              V.1.0 // OFFLINE',
                      style: GoogleFonts.shareTechMono(
                        color: AppColors.textMuted,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

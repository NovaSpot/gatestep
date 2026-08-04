import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/cyber_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Character avatar
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.textSecondary.withAlpha(60),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryCyan.withAlpha(20),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  'assets/images/avatar_home.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.surfaceLight,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: AppColors.primaryCyan.withAlpha(60),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Stats row 1
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'TOTAL_XP',
                    value: '12,450',
                    unit: 'XP',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    label: 'GATES_CLEARED',
                    value: '04',
                    unit: 'GTS',
                    valueColor: AppColors.primaryCyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Stats row 2
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'DISTANCE',
                    value: '42.8',
                    unit: 'KM',
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 40),
            // Start Hunting button
            CyberButton(
              text: 'START HUNTING',
              icon: Icons.shield_outlined,
              onPressed: () {
                Navigator.pushNamed(context, '/setDistance');
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

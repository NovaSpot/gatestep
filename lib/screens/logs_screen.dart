import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/cyber_card.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HUNT ARCHIVE',
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'SYSTEM_OS // ARCHIVE_ACCESS_GRANTED',
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildLogEntry(
                    id: 'LOG_014${0 - index}',
                    title: index == 0 ? 'CUSAT to SOE' : 'HMT to CR',
                    date: '2042.11.22',
                    time: '30:15',
                    distance: index == 0 ? '2' : '5',
                    xp: index == 0 ? '+850' : '+1200',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry({
    required String id,
    required String title,
    required String date,
    required String time,
    required String distance,
    required String xp,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.textSecondary.withAlpha(40), width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.textSecondary.withAlpha(40), width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.public, size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  id,
                  style: GoogleFonts.shareTechMono(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rank Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textSecondary.withAlpha(60), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'A',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.shareTechMono(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: GoogleFonts.shareTechMono(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.timer_outlined, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: GoogleFonts.shareTechMono(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DISTANCE',
                                  style: GoogleFonts.shareTechMono(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      distance,
                                      style: GoogleFonts.shareTechMono(
                                        color: AppColors.textPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'KM',
                                      style: GoogleFonts.shareTechMono(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'XP GAIN',
                                  style: GoogleFonts.shareTechMono(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  xp,
                                  style: GoogleFonts.shareTechMono(
                                    color: AppColors.primaryCyan,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textSecondary.withAlpha(40)),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

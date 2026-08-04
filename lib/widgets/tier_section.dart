import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class TierSection extends StatelessWidget {
  final String tierName;
  final Color borderColor;
  final List<CharacterCard> characters;

  const TierSection({
    super.key,
    required this.tierName,
    required this.borderColor,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tier header label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: borderColor, width: 3),
            ),
            color: AppColors.surface,
          ),
          child: Text(
            'CLASS // $tierName',
            style: GoogleFonts.shareTechMono(
              color: borderColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Character cards row
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor.withAlpha(60), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: characters.map((card) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: card,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class CharacterCard extends StatelessWidget {
  final String name;
  final String id;
  final String imagePath;
  final Color borderColor;

  const CharacterCard({
    super.key,
    required this.name,
    required this.id,
    required this.imagePath,
    this.borderColor = AppColors.primaryCyan,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor.withAlpha(80), width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceLight,
                        child: Icon(
                          Icons.person,
                          color: borderColor.withAlpha(60),
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    color: Colors.black54,
                    child: Text(
                      'ID:$id',
                      style: GoogleFonts.shareTechMono(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.shareTechMono(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class MapPreview extends StatelessWidget {
  final String? label;
  final bool showCoordinates;
  final double height;

  const MapPreview({
    super.key,
    this.label = 'PREVIEW // TERRITORY',
    this.showCoordinates = true,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border.all(color: AppColors.primaryCyan.withAlpha(40), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: CustomPaint(
            painter: _MapGridPainter(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: AppColors.primaryCyan.withAlpha(80),
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'MAP TERRITORY',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textSecondary.withAlpha(100),
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (label != null)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: AppColors.surface.withAlpha(200),
              child: Text(
                label!,
                style: GoogleFonts.shareTechMono(
                  color: AppColors.primaryCyan,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (showCoordinates)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface.withAlpha(220),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LAT: 35.6762° N',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'LNG: 139.6503° E',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryCyan.withAlpha(15)
      ..strokeWidth = 0.5;

    // Draw grid lines
    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw some "road" lines
    final roadPaint = Paint()
      ..color = AppColors.primaryCyan.withAlpha(25)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.5, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, 0),
      Offset(size.width * 0.8, size.height),
      roadPaint,
    );

    // Draw a route line
    final routePaint = Paint()
      ..color = AppColors.primaryCyan.withAlpha(60)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final routePath = Path();
    routePath.moveTo(size.width * 0.3, size.height * 0.7);
    routePath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width * 0.7,
      size.height * 0.5,
    );
    canvas.drawPath(routePath, routePaint);

    // Draw dot markers
    final dotPaint = Paint()
      ..color = AppColors.primaryCyan.withAlpha(80)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.7), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CyberCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final EdgeInsets padding;
  final bool showCornerTicks;
  final String? label;

  const CyberCard({
    super.key,
    required this.child,
    this.borderColor = AppColors.primaryCyan,
    this.padding = const EdgeInsets.all(16),
    this.showCornerTicks = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: borderColor.withAlpha(80), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: child,
        ),
        if (label != null)
          Positioned(
            top: -10,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: AppColors.background,
              child: Text(
                label!,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: borderColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        if (showCornerTicks) ..._buildCornerTicks(),
      ],
    );
  }

  List<Widget> _buildCornerTicks() {
    const double tickSize = 12;
    const double tickThickness = 1.5;

    Widget cornerTick(
        {required AlignmentGeometry alignment,
        required bool top,
        required bool left}) {
      return Positioned(
        top: top ? -1 : null,
        bottom: top ? null : -1,
        left: left ? -1 : null,
        right: left ? null : -1,
        child: SizedBox(
          width: tickSize,
          height: tickSize,
          child: CustomPaint(
            painter: _CornerTickPainter(
              color: borderColor,
              thickness: tickThickness,
              topLeft: top && left,
              topRight: top && !left,
              bottomLeft: !top && left,
              bottomRight: !top && !left,
            ),
          ),
        ),
      );
    }

    return [
      cornerTick(alignment: Alignment.topLeft, top: true, left: true),
      cornerTick(alignment: Alignment.topRight, top: true, left: false),
      cornerTick(alignment: Alignment.bottomLeft, top: false, left: true),
      cornerTick(alignment: Alignment.bottomRight, top: false, left: false),
    ];
  }
}

class _CornerTickPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool topLeft, topRight, bottomLeft, bottomRight;

  _CornerTickPainter({
    required this.color,
    required this.thickness,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (topLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (topRight) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (bottomLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else if (bottomRight) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

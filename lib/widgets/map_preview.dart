import 'package:flutter/material.dart';
import 'route_map_view.dart';

class MapPreview extends StatelessWidget {
  final String? label;
  final bool showCoordinates;
  final double height;
  final List<Map<String, double>>? routePoints;

  const MapPreview({
    super.key,
    this.label = 'PREVIEW // TERRITORY',
    this.showCoordinates = true,
    this.height = 200,
    this.routePoints,
  });

  @override
  Widget build(BuildContext context) {
    return RouteMapView(
      routePoints: routePoints ?? const [],
      label: label,
      showCoordinates: showCoordinates,
      height: height,
    );
  }
}

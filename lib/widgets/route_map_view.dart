import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_colors.dart';

class RouteMapView extends StatelessWidget {
  final List<Map<String, double>> routePoints;
  final String? label;
  final bool showCoordinates;
  final double height;
  final bool isInteractive;

  const RouteMapView({
    super.key,
    required this.routePoints,
    this.label = 'TERRITORY // LIVE GPS',
    this.showCoordinates = true,
    this.height = 240,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<LatLng> points = routePoints
        .map((p) => LatLng(p['lat'] ?? 0.0, p['lng'] ?? 0.0))
        .toList();

    // Default center (Tokyo / fallback) if no route points yet
    final LatLng center = points.isNotEmpty
        ? points.last
        : const LatLng(35.6762, 139.6503);

    final LatLng? startPoint = points.isNotEmpty ? points.first : null;
    final LatLng? endPoint = points.isNotEmpty ? points.last : null;

    final MapController mapController = MapController();

    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border.all(color: AppColors.primaryCyan.withAlpha(50), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          clipBehavior: Clip.antiAlias,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: points.length > 1 ? 15.0 : 14.0,
              interactionOptions: InteractionOptions(
                flags: isInteractive ? InteractiveFlag.all : InteractiveFlag.none,
              ),
            ),
            children: [
              // CartoDB Dark Matter tiles (Dark Cyberpunk Theme)
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.gatestep',
              ),
              // Polyline track layer
              if (points.length > 1)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 4.0,
                      color: AppColors.primaryCyan,
                    ),
                  ],
                ),
              // Markers layer
              MarkerLayer(
                markers: [
                  // Start marker
                  if (startPoint != null)
                    Marker(
                      point: startPoint,
                      width: 24,
                      height: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryCyan.withAlpha(200),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryCyan, width: 2),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 12,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  // Current / End Marker
                  if (endPoint != null)
                    Marker(
                      point: endPoint,
                      width: 30,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryCyan,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryCyan.withAlpha(180),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.my_location,
                          size: 16,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        // Cyberpunk label tag
        if (label != null)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: AppColors.surface.withAlpha(220),
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
        // Coordinates overlay tag
        if (showCoordinates)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface.withAlpha(230),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.primaryCyan.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LAT: ${center.latitude.toStringAsFixed(4)}°',
                    style: GoogleFonts.shareTechMono(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'LNG: ${center.longitude.toStringAsFixed(4)}°',
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatelessWidget {
  final LatLng position;
  final VoidCallback onTap;

  const CustomMarker({required this.position, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.location_on,
        color: Colors.green,
        size: 40.0,
      ),
    );
  }
}

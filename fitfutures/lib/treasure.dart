import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class TreasureMap extends StatefulWidget {
  const TreasureMap({super.key});

  @override
  State<TreasureMap> createState() => TreasureMapState();
}

class TreasureMapState extends State<TreasureMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _currentPosition;
  bool isLoading = true;
  final location.Location _location = location.Location();

  @override
  void initState() {
    super.initState();
    getLocation();

    _location.onLocationChanged.listen((location.LocationData currentLocation) {
      setState(() {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              circles: {
                Circle(
                  circleId: const CircleId('currentCircle'),
                  center: _currentPosition!,
                  radius: 4000,
                  fillColor: Colors.blue.shade100.withOpacity(0.5),
                  strokeColor: Colors.blue.shade100.withOpacity(0.1),
                ),
              },
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: _currentPosition!, zoom: 10),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}

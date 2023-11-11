import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:flutter/services.dart' show rootBundle;
import 'widgets/custom_marker.dart';


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
  late String _mapStyle;

  @override
  void initState() {
    super.initState();
    getLocation();
  
  rootBundle.loadString('assets/map_theme.json').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
  }

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

  Set<Marker> _markers = Set<Marker>();

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
               controller.setMapStyle(_mapStyle);

                _addMarkers();
              },
              markers: _markers,
            ),
    );
  }
   
  void _addMarkers() {
    List<LatLng> coordinates = [
      LatLng(37.42, -122.08),
      LatLng(37.43, -122.09),
      LatLng(37.44, -122.11),
    ];

    _markers.clear();

    for (var coord in coordinates) {
      _markers.add(
        Marker(
            markerId: MarkerId(coord.toString()),
            position: coord,
            onTap: () {
              _onMarkerTapped(coord);
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)),
      );
    }
  }

  void _onMarkerTapped(LatLng position) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Center(
              child: Text(
                'Custom Marker Tapped at (${position.latitude}, ${position.longitude})',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        });
  }
}

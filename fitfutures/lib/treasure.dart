import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/custom_marker.dart';

class TreasureMap extends StatefulWidget {
  const TreasureMap({super.key});

  @override
  State<TreasureMap> createState() => TreasureMapState();
}

class TreasureMapState extends State<TreasureMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_theme.json').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kpos = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
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

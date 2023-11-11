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
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

  Future<void> _addMarkers() async {
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
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(devicePixelRatio: 2.0),
                'assets/map_marker.png'),
            onTap: () {
              _onMarkerTapped(coord);
            }),
      );
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _onMarkerTapped(LatLng position) async {
    BuildContext context = _scaffoldKey.currentContext!;

    Size screenSize = MediaQuery.of(context).size;

    double centerX = screenSize.width / 2;
    double centerY = screenSize.height / 2;

    // Show the popup menu and wait for user selection
    String? result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          centerX - 140, centerY - 225, centerX + 140, centerY + 135),
      items: [
        PopupMenuItem<String>(
          value: 'item1',
          child: Center(
            child: Container(
              width: 150, // Set the desired width
              height: 200, // Set the desired height
              padding: const EdgeInsets.all(16.0),
              child: const Center(
                  child: Text(
                '?',
                style: TextStyle(fontSize: 150.0, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'item2',
          child: Center(
            child: Container(
              width: 250, // Set the desired width
              height: 60, // Set the desired height
              //padding: const EdgeInsets.all(16.0),
              child: const Center(
                  child: Text(
                'Challenge:',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'item3',
          child: Center(
            child: Container(
              width: 250, // Set the desired width
              height: 150, // Set the desired height
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: const Text('Variant 1'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                          print("Button value: $value");
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Variant 2'),
                    leading: Radio(
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                          print("Button value: $value");
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    // Handle the selected item
    if (result != null) {
      // Perform actions based on the selected item
      print('Selected item: $result');
    }
  }
}

import 'dart:async';
import 'dart:math';

import 'package:fitfutures/model/treasure.dart';
import 'package:fitfutures/service/treasure_service.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:flutter/services.dart' show rootBundle;

class TreasureMap extends StatefulWidget {
  const TreasureMap({super.key});

  @override
  State<TreasureMap> createState() => _TreasureMapState();
}

class _TreasureMapState extends State<TreasureMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? _currentPosition;
  bool isLoading = true;
  final location.Location _location = location.Location();
  late String _mapStyle;
  Set<Marker> _markers = <Marker>{};
  TreasureService service = TreasureService();

  Future<List<Treasure>> fetchTreasures() async {
    return await service.getAll();
  }

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

  void getLocation() async {
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

  void _addMarkers() async {
    List<Treasure> treasures = await fetchTreasures();
    _markers.clear();

    for (Treasure treasure in treasures) {
      _markers.add(
        Marker(
          markerId: MarkerId(treasure.id.toString()),
          position: LatLng(treasure.cordy, treasure.cordx),
          onTap: () {
            _onMarkerTapped();
          },
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 2.0),
              'assets/typescript-logo-24.png'),
        ),
      );
    }
  }

  void _onMarkerTapped() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Custom Marker Tapped at ()',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        });
  }

  double calculateDistance(LatLng latLng1, LatLng myPos) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((myPos.latitude - latLng1.latitude) * p) / 2 +
        c(latLng1.latitude * p) *
            c(myPos.latitude * p) *
            (1 - c((myPos.longitude - latLng1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  Set<Marker> filterMarkers() {
    Set<Marker> cloneMarkers = Set.from(_markers);
    cloneMarkers.retainWhere((element) =>
        calculateDistance(element.position, _currentPosition!) <= 5);
    return cloneMarkers;
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
                  radius: 5000,
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
              markers: filterMarkers(),
            ),
    );
  }
}

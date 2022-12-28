import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const _initialPos =
      CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPos,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
      ),
    );
  }
}

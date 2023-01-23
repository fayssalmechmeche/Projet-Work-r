import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const _initialPos =
      CameraPosition(target: LatLng(48.866667, 2.333333), zoom: 11.5);

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

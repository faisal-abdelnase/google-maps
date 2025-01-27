import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    _initialCameraPosition = const CameraPosition(
      // this is initial latitude and longitude of the camera
      target: LatLng(29.86398403496827, 31.302744328217248),
      // this is the zoom level of the camera

      /**
       * world view 0 -> 3
       * country view 4 -> 6
       * city view 10 -> 12
       * street view 13 -> 17
       * building view 18 -> 20
       */
      zoom: 12,

      );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // this is the initial camera position
      //this is position of the camera when the map is loaded

      initialCameraPosition: _initialCameraPosition,

      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: const LatLng(29.807648253116163, 31.285068517341518),
          northeast: const LatLng(29.872582673055934, 31.3727441268497),
          ),
      ),
      );
  }
}
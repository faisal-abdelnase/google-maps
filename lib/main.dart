import 'package:flutter/material.dart';
import 'package:google_maps/widgets/custom_google_map.dart';

void main() {
  runApp(const GoogleMaps());
}

class GoogleMaps extends StatelessWidget {
  const GoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps',
      home: CustomGoogleMap()
    );
  }
}
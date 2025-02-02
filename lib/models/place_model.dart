import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLong;

  PlaceModel({required this.id, required this.name, required this.latLong});

}

List<PlaceModel> places = [
  PlaceModel(
    id: 1, 
    name: "Japanese garden", 
    latLong: const LatLng(29.850049845029098, 31.340459028109382),
    ),

    PlaceModel(
    id: 2, 
    name: "Helwan General Club", 
    latLong: const LatLng(29.843587027862636, 31.342500437337772),
    ),

    PlaceModel(
    id: 3, 
    name: "Cyber PC", 
    latLong: const LatLng(29.84511510781167, 31.330146979891676),
    ),

];

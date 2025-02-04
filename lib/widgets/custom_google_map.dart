import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  late CameraPosition _initialCameraPosition;

  Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};

  @override
  void initState() {
    _initialCameraPosition = const CameraPosition(
      // this is initial latitude and longitude of the camera
      target: LatLng(29.86398403496827, 31.302744328217248),
      zoom: 12,

      );


      initMarkers();
      initPolygons();

      
    super.initState();
  }


  

  late GoogleMapController _googleMapController;


  @override
  Widget build(BuildContext context) {
    return 
    
    GoogleMap(
          
    initialCameraPosition: _initialCameraPosition,
    
    mapType: MapType.normal,
    markers: _markers,
    polygons: _polygons,

    // zoomControlsEnabled: false,

    onMapCreated: (controller) {
      _googleMapController = controller;
      initMapStyle();
    },

    
    );
  }


  

  void initMapStyle() async{
    
    var nightMapStyle = await DefaultAssetBundle.of(context).
    loadString('assets/maps_styles/night_map_style.json');

    _googleMapController.setMapStyle(nightMapStyle);
  }




  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(), targetWidth: width.round());

    var imageFrame = await imageCodec.getNextFrame();

    var imageBytData = await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

    return imageBytData!.buffer.asUint8List();

  }
  
  void initMarkers() async {
    var customMarkerIcon = BitmapDescriptor.bytes(await getImageFromRawData('assets/images/marker.png', 50));
    places.map((place) {
      _markers.add(
        Marker(
        icon: customMarkerIcon,
        markerId: MarkerId(place.id.toString()),
        position: place.latLong,
        infoWindow: InfoWindow(
          title: place.name,
        ),
      ));
    }).toSet();

    setState(() {
      
    });
  }



  




  
  void initPolygons() {
    Polygon polygon1 = Polygon(
      holes: const [[ 
        LatLng(29.845457922458667, 31.336319168431356),
        LatLng(29.845431601490677, 31.335226722121526),
        LatLng(29.844931501049505, 31.337381268932916),]],
      polygonId: const PolygonId('1'),
      fillColor: Colors.red.withOpacity(0.5),
      strokeColor: Colors.orange,
      strokeWidth: 2,
      points: const [
        LatLng(29.850049845029098, 31.340459028109382),
        LatLng(29.843587027862636, 31.342500437337772),
        LatLng(29.84511510781167, 31.330146979891676),
      ],
    );

    _polygons.add(polygon1);
  }

}
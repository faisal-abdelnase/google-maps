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


      initMarkers();

      
    super.initState();
  }


  

  late GoogleMapController _googleMapController;


  @override
  Widget build(BuildContext context) {
    return 
    
    GoogleMap(
    // this is the initial camera position
    //this is position of the camera when the map is loaded
    // no update to initialCameraPosition
          
    initialCameraPosition: _initialCameraPosition,
    
    mapType: MapType.normal,

    markers: _markers,

    zoomControlsEnabled: false,

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

}
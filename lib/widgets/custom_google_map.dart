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
  Set<Polyline> _polylines = {};

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

      initPolyLines();

      
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
    polylines: _polylines,

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



  
  void initPolyLines() {
    Polyline polyline1 =  Polyline(
      polylineId: const PolylineId('1'),
      color: Colors.red,
      width: 5,
      startCap: Cap.roundCap,
      zIndex: 10,
      patterns: [
        PatternItem.dash(20),
        PatternItem.gap(10),
      ],
      geodesic: true,
      points: const [
        LatLng(29.850049845029098, 31.340459028109382),
        LatLng(29.843587027862636, 31.342500437337772),
        LatLng(29.84511510781167, 31.330146979891676),
      ],
    );



    Polyline polyline2 = const Polyline(
      polylineId: PolylineId('2'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      zIndex: 5,
      points: [
        LatLng(29.854194245099112, 31.335932166539973),
        LatLng(29.83826211060132, 31.33349873964596),
        
      ],
    );

    _polylines.add(polyline1);
    _polylines.add(polyline2);

  }

}
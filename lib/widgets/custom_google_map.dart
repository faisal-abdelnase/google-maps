
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  late CameraPosition _initialCameraPosition;
  late Location location;

  @override
  void initState() {
    _initialCameraPosition = const CameraPosition(
      // this is initial latitude and longitude of the camera
      target: LatLng(29.86398403496827, 31.302744328217248),
      zoom: 12,

      );

    location = Location();

      checkAndRequestLocationService();

      
    super.initState();
  }


  

  late GoogleMapController _googleMapController;


  @override
  Widget build(BuildContext context) {
    return 
    
    GoogleMap(
          
    initialCameraPosition: _initialCameraPosition,
    
    mapType: MapType.normal,

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


  
  void checkAndRequestLocationService() async {
    var isServiceEnable = await location.serviceEnabled();

    if(!isServiceEnable){
      isServiceEnable = await location.requestService();
      if(!isServiceEnable){
        return;
      }
    }

    checkAndRequestLocationPermission();
  }




  
  void checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();

    if(permissionStatus == PermissionStatus.denied){
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted){
        return;
    }
  }

  
  
  




  
  

  }
}

















// Future<Uint8List> getImageFromRawData(String image, double width) async {
//     var imageData = await rootBundle.load(image);
//     var imageCodec = await ui.instantiateImageCodec(
//       imageData.buffer.asUint8List(), targetWidth: width.round());

//     var imageFrame = await imageCodec.getNextFrame();

//     var imageBytData = await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

//     return imageBytData!.buffer.asUint8List();

//   }
  
//   void initMarkers() async {
//     var customMarkerIcon = BitmapDescriptor.bytes(await getImageFromRawData('assets/images/marker.png', 50));
//     places.map((place) {
//       _markers.add(
//         Marker(
//         icon: customMarkerIcon,
//         markerId: MarkerId(place.id.toString()),
//         position: place.latLong,
//         infoWindow: InfoWindow(
//           title: place.name,
//         ),
//       ));
//     }).toSet();

//     setState(() {
      
//     });
//   }











// void initCircles() {
//     Circle circle = Circle(
//       circleId: CircleId('1'),
//       center: LatLng(29.848958554535614, 31.340294458987763),
//       radius: 5000,
//       fillColor: Colors.blue.withOpacity(0.3),
//       strokeWidth: 1,
//       strokeColor: Colors.red,
//     );
//     _circles.add(circle);
//   }



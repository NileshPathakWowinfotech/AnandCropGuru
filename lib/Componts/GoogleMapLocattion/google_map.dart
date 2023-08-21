// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../utils/Colors.dart';



// class ShopGoogleMapLocation extends StatefulWidget {
//   const ShopGoogleMapLocation({Key? key, this.name}) : super(key: key);
//   final name ;



//   @override
//   State<ShopGoogleMapLocation> createState() => _ShopGoogleMapLocationState();
// }

// class _ShopGoogleMapLocationState extends State<ShopGoogleMapLocation> {
//   //get map controller to access map
//   Completer<GoogleMapController> _googleMapController = Completer();
//   CameraPosition? _cameraPosition;
//   late LatLng _defaultLatLng;
//   late LatLng _draggedLatlng;
//   String _draggedAddress = "";
//   String _draggedAddress2 = "";
//   String _Lat = "";
//   String _Lnt = "";
//   String _district = "";


//   @override
//   void initState() {
//     _init();
//     super.initState();
//   }

//   _init() {
//     //set default latlng for camera position
//     _defaultLatLng = LatLng(11, 104);
//     _draggedLatlng = _defaultLatLng;
//     _cameraPosition =
//         CameraPosition(target: _defaultLatLng, zoom: 17.5 // number of map view
//         );

//     //map will redirect to my current location when loaded
//     _gotoUserCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: _buildBody(),
//       //get a float button to click and go to current location
//     );
//   }

//   Widget _currentlocationBack() {
//     return Positioned(
//       top: 110,
//       right: 20,
//       child: CircleAvatar(
//         radius: 20,
//         backgroundColor: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             _gotoUserCurrentPosition();
//           },

//         ),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return Stack(children: [
//       _getMap(),
//      // _getCustomPin(),

//       Positioned(
//           top: 20,
//           right:
//           10,
//           child: currentLocation()),
//       _confirmBtn(),

//     ]);
//   }
//   Widget currentLocation() {
//     return Column(

//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [

//         InkWell(
//           onTap: (){
//             _gotoUserCurrentPosition();
//           },
//           child: Container(
//             height: 38,
//             width: 40,

//             decoration: BoxDecoration(
//                 color: kWhite,
//                 border: Border.all(width: 1 , color: kblack),
//                 borderRadius: BorderRadius.circular(5)
//             ),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset("assets/images/target.png" ,height: 25, color: kblack,),


//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _confirmBtn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Column(
//           children: [




//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 100),
//               child: InkWell(
//                 onTap: (){
//                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RegisterYourShop(shopAddress: _draggedAddress, )));
//                 },
//                 child: Container(
//                   height: 40,

//                   decoration: BoxDecoration(
//                     color: kblack,
//                     borderRadius: BorderRadius.circular(10),

//                   ),
//                   child: Center(child: Text("Select Location",style: TextStyle(color: kWhite ,  fontWeight: FontWeight.bold ))),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }




//   Widget _getMap() {
//     return GoogleMap(
//       initialCameraPosition:
//       _cameraPosition!, //initialize camera position for map
//       mapType: MapType.normal,
//       onCameraIdle: () {
//         //this function will trigger when user stop dragging on map
//         //every time user drag and stop it will display address
//         _getAddress(_draggedLatlng);
//       },
//       onCameraMove: (cameraPosition) {
//         //this function will trigger when user keep dragging on map
//         //every time user drag this will get value of latlng
//         _draggedLatlng = cameraPosition.target;
//       },
//       onMapCreated: (GoogleMapController controller) {
//         //this function will trigger when map is fully loaded
//         if (!_googleMapController.isCompleted) {
//           //set controller to google map when it is fully loaded
//           _googleMapController.complete(controller);
//         }
//       },
//     );
//   }


//   //get address from dragged pin
//   Future _getAddress(LatLng position) async {
//     //this will list down all address around the position
//     List<Placemark> placemarks =
//     await placemarkFromCoordinates(position.latitude, position.longitude);
//     _Lat = position.latitude.toString();
//     _Lnt = position.longitude.toString();
//     Placemark address = placemarks[0]; // get
//     // only first and closest address
//     String district = ' ${address.subAdministrativeArea}';
//     String location = '${address.street} ,${address.subLocality},${address.administrativeArea}';
//     String addresStr =
//         '${address.street}, ${address.subLocality}, ${address.subAdministrativeArea},${address.administrativeArea},${address.postalCode}, ${address.country}';
//     setState(() {
//       _draggedAddress = addresStr;
//       _district = district;
//       _draggedAddress2 = location;
//       print(addresStr);
//     });
//   }

//   //get user's current location and set the map's camera to that location
//   Future _gotoUserCurrentPosition() async {
//     Position currentPosition = await _determineUserCurrentPosition();
//     _gotoSpecificPosition(
//         LatLng(currentPosition.latitude, currentPosition.longitude));
//   }

//   //go to specific position by latlng
//   Future _gotoSpecificPosition(LatLng position) async {
//     GoogleMapController mapController = await _googleMapController.future;
//     mapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: position, zoom: 17.5)));
//     //every time that we dragged pin , it will list down the address here
//     await _getAddress(position);
//   }

//   Future _determineUserCurrentPosition() async {
//     LocationPermission locationPermission;

//     bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     //check if user enable service for location permission
//     if (!isLocationServiceEnabled) {

//       print("user don't enable location permission");
//     }

//     locationPermission = await Geolocator.checkPermission();

//     //check if user denied location and retry requesting for permission
//     if (locationPermission == LocationPermission.denied) {
//       locationPermission = await Geolocator.requestPermission();
//       if (locationPermission == LocationPermission.denied) {
//         print("user denied location permission");
//       }
//     }

//     //check if user denied permission forever
//     if (locationPermission == LocationPermission.deniedForever) {
//       print("user denied permission forever");
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//   }


// }

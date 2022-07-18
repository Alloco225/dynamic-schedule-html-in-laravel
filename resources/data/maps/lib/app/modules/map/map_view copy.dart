// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ici/app/const.dart';
// import 'package:ici/app/modules/map/add_place_view.dart';
// import 'package:ici/app/modules/map/search_view.dart';
// import 'package:ici/app/modules/profile/views/profile_view.dart';
// import 'package:ici/app/utils/utils.dart';
// import 'package:ici/map_modules/custom_marker.dart';
// import 'package:location/location.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// import 'profile_view.dart';

// class MapView1 extends StatefulWidget {
//   MapView1({Key? key}) : super(key: key);

//   @override
//   State<MapView1> createState() => _MapView1State();
// }

// class _MapView1State extends State<MapView1> {
//   late MapboxMapController mapController;

//   int _pageViewCurrentIndex = 0;
//   late final _pageViewController = PageController(viewportFraction: .8);
//   LocationData? _currentLocation;
//   final latLngAbj = LatLng(5.316667, -4.033333);
//   LatLng currentLatLng = LatLng(5.316667, -4.033333);
//   double _mapZoom = 5;

//   // Scaffold
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // final double _mapMaxZoom = 19;
//   final double _mapMaxZoom = 25;
//   final double _mapMinZoom = 2;
//   bool _liveUpdate = true;
//   bool _keepUserPositionInCenter = false;

//   bool _permission = false;
//   final _debug = false;
//   List<LatLng> _points = [];
//   List<LatLng> _ghostPoints = [];
//   bool _showGhostPoints = false;
//   bool _isModalOpen = false;
//   bool __appMounted = false;
//   bool _placeAddingMode = false;

//   // Exit on double back press
//   DateTime? currentBackPressTime;

//   /// Connectivity
//   var isDeviceConnected = true;
//   //late final StreamSubscription<InternetConnectionStatus> connectivityListener;

//   // List<List<LatLng>> _savedPolylinesPoints = [];
//   final List<List<LatLng>> _savedPolygonsPoints = [];
//   List<List<LatLng>> _itineraryPoints = [];
//   // List<Polygon> _savedPolygons = [];
//   // Map markers only for the map places
//   // var mapPlacesMarkers = <Marker>[];
//   // markers for user current position and user places
//   // var markers = <Marker>[];
//   List<Marker> _markers = [];

//   final GlobalKey<FabCircularMenuState> leftFabKey = GlobalKey();
//   final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

//   String? _serviceError = '';

//   final Location _locationService = Location();

//   var isLight = true;

//   @override
//   void initState() {
//     super.initState();
//     initLocationService();
//   }

//   _onMapCreated(MapboxMapController controller) {
//     mapController = controller;
//   }

//   _onStyleLoadedCallback() {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("Style loaded :)"),
//       backgroundColor: Theme.of(context).primaryColor,
//       duration: Duration(seconds: 1),
//     ));
//   }

//   // void _addMarker(Point<double> point, LatLng coordinates) {
//   //   setState(() {
//   //     _markers.add(Marker(_rnd.nextInt(100000).toString(), coordinates, point,
//   //         _addMarkerStates));
//   //   });
//   // }

//   void initLocationService() async {
//     bool serviceEnabled;

//     try {
//       var permission = await _locationService.requestPermission();
//       _permission = permission == PermissionStatus.granted ||
//           permission == PermissionStatus.grantedLimited;

//       await _locationService.requestService();
//       serviceEnabled = await _locationService.serviceEnabled();

//       var text = '';
//       var title = '';

//       debugPrint(
//           '\n\n\n\n>>>>>><<<<<< initLocationService s:$serviceEnabled p:$_permission \n\n\n\n');

//       if (!serviceEnabled) {
//         title += '\nLocalisation Désactivée';
//         text += '\nVeuillez activer votre localisation';
//         await _locationService.requestService();
//       }
//       if (!_permission) {
//         title += '\nPermission refusée';
//         text += "\nL'application a besoin de votre localisation";
//         await _locationService.requestPermission();
//       }

//       if (permission == PermissionStatus.deniedForever) {
//         title = '\nPermission refusée pour toujours';
//         text =
//             "\n Vous avez désactivé l'accès à votre localisation pour cette application pour toujours\n Veuillez aller dans vos réglages et activer la permission pour utiliser l'application";
//         await showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (ctx) => AlertDialog(
//             title: Text(title),
//             content: Text(text),
//             actions: [
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(ctx).pop();
//                   initLocationService();
//                 },
//                 child: const Text('Réessayer'),
//               )
//             ],
//           ),
//         );
//         return;
//       }

//       if (!serviceEnabled || !_permission) {
//         await showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text(title),
//             content: Text(text),
//             actions: [
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(ctx).pop();
//                   initLocationService();
//                 },
//                 child: const Text('Réessayer'),
//               )
//             ],
//           ),
//         );

//         initLocationService();
//         return;
//       }

//       // permission = await _locationService.requestPermission();

//       if (_permission && serviceEnabled) {
//         await _locationService.changeSettings(
//           accuracy: LocationAccuracy.high,
//           interval: 1000,
//         );
//         //
//         // if (!__appMounted) {
//         _mapZoom = 17;
//         // }

//         _currentLocation = await _locationService.getLocation();
//         setState(() {});
//         debugPrint('\n\n\n>>>> _permission ');
//         if (_currentLocation != null) {
//           //
//           mapController.animateCamera(
//             CameraUpdate.newLatLngZoom(
//               LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
//               11.0,
//               // LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
//               // _mapZoom);
//             ),
//           );
//         }
//         _locationService.onLocationChanged.listen((LocationData result) async {
//           // if (mounted) {
//           setState(() {
//             _currentLocation = result;
//             // If Live Update is enabled, move map center
//             // if (_keepUserPositionInCenter) {
//             if (_placeAddingMode) {
//               //
//             }
//           });
//           // }
//         });
//       }
//     } on PlatformException catch (e) {
//       debugPrint('>>>> eeror $e');
//       if (e.code == 'PERMISSION_DENIED') {
//         _serviceError = e.message;
//         // __snackbar('Permission refusée');
//       } else if (e.code == 'SERVICE_STATUS_ERROR') {
//         _serviceError = e.message;
//         // __snackbar('Impossible de déterminer le status de la localisation');
//       }
//       _currentLocation = null;
//       initLocationService();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//     void _showSnackBar(BuildContext context, String message) {
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text(message),
//         duration: const Duration(milliseconds: 1000),
//       ));
//     }

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//               child: Container(
//             color: Colors.blue,
//           )),
//           //     Positioned.fill(
//           //       child: MapboxMap(
//           //         styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
//           //         accessToken: ENV.ACCESS_TOKEN,
//           //         trackCameraPosition: true,
//           //         // onMapLongClick: _onMapLongClickCallback,
//           //         // onCameraIdle: _onCameraIdleCallback,

//           //         onMapCreated: _onMapCreated,
//           //         initialCameraPosition:
//           //             const CameraPosition(target: LatLng(0.0, 0.0)),
//           //         onStyleLoadedCallback: _onStyleLoadedCallback,
//           //         myLocationEnabled: true,
//           //         myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
//           //         minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
//           //         myLocationRenderMode: MyLocationRenderMode.NORMAL,
//           //       ),
//           //     ),
//           //     // * Custom markers
//         ],
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FabCircularMenu(
//           key: fabKey,
//           // Cannot be `Alignment.center`
//           alignment: Alignment.bottomCenter,
//           ringColor: Colors.black.withAlpha(25),
//           // ringDiameter: 350.0,
//           // ringWidth: 200.0,
//           ringDiameter: 350,
//           ringWidth: 100,
//           fabSize: 64.0,
//           fabElevation: 8.0,
//           fabIconBorder: CircleBorder(),
//           // Also can use specific color based on wether
//           // the menu is open or not:
//           // fabOpenColor: Colors.white
//           // fabCloseColor: Colors.white
//           // These properties take precedence over fabColor
//           fabColor: Colors.white,
//           fabOpenIcon: Icon(Icons.menu, color: primaryColor),
//           fabCloseIcon: Icon(Icons.close, color: primaryColor),
//           animationDuration: const Duration(milliseconds: 800),
//           animationCurve: Curves.easeInOutCirc,
//           onDisplayChange: (isOpen) {},
//           children: <Widget>[
//             RawMaterialButton(
//               onPressed: () {},
//               shape: CircleBorder(),
//               padding: const EdgeInsets.all(24.0),
//               child: Icon(Icons.gps_fixed, color: Colors.white),
//             ),
//             RawMaterialButton(
//               onPressed: () {
//                 fabKey.currentState!.close();
//                 openModalBottomSheet(context, view: SearchView());
//               },
//               shape: CircleBorder(),
//               padding: const EdgeInsets.all(24.0),
//               child: Icon(Icons.search, color: Colors.white),
//             ),
//             RawMaterialButton(
//               onPressed: () {
//                 fabKey.currentState!.close();
//                 openModalBottomSheet(context, view: AddPlaceView());
//               },
//               shape: CircleBorder(),
//               padding: const EdgeInsets.all(24.0),
//               child: Icon(Icons.map, color: Colors.white),
//             ),
//             RawMaterialButton(
//               onPressed: () {
//                 fabKey.currentState!.close();
//                 openModalBottomSheet(context, view: UserProfileView());
//               },
//               shape: CircleBorder(),
//               padding: const EdgeInsets.all(24.0),
//               child: Icon(Icons.person_outline, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NoScalingAnimation extends FloatingActionButtonAnimator {
//   late double _x;
//   late double _y;
//   @override
//   Offset getOffset({
//     required Offset begin,
//     required Offset end,
//     required double progress,
//   }) {
//     _x = begin.dx + (end.dx - begin.dx) * progress;
//     _y = begin.dy + (end.dy - begin.dy) * progress;
//     return Offset(_x, _y);
//   }

//   @override
//   Animation<double> getRotationAnimation({
//     required Animation<double> parent,
//   }) {
//     return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
//   }

//   @override
//   Animation<double> getScaleAnimation({
//     required Animation<double> parent,
//   }) {
//     return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
//   }
// }

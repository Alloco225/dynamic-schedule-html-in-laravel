import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ici/app/const/env.dart';
import 'package:ici/app/modules/map/add_place_view.dart';
import 'package:ici/app/modules/map/search_view.dart';
import 'package:ici/app/modules/map/share_current_position_view.dart';
import 'package:ici/app/utils/utils.dart';
import 'package:ici/app/widgets/clippers.dart';
import 'package:ici/map_modules/custom_marker.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import 'profile_view.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapboxMapController mapController;

  int _pageViewCurrentIndex = 0;
  late final _pageViewController = PageController(viewportFraction: .8);
  LocationData? _currentLocation;
  final latLngAbj = LatLng(5.316667, -4.033333);
  LatLng currentLatLng = LatLng(5.316667, -4.033333);
  double _mapZoom = 5;

  // Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final double _mapMaxZoom = 19;
  final double _mapMaxZoom = 25;
  final double _mapMinZoom = 2;
  bool _liveUpdate = true;
  bool _keepUserPositionInCenter = false;

  bool _permission = false;
  final _debug = false;
  List<LatLng> _points = [];
  List<LatLng> _ghostPoints = [];
  bool _showGhostPoints = false;
  bool _isModalOpen = false;
  bool __appMounted = false;
  bool _menuOpen = false;

  // Exit on double back press
  DateTime? currentBackPressTime;

  /// Connectivity
  var isDeviceConnected = true;
  //late final StreamSubscription<InternetConnectionStatus> connectivityListener;

  // List<List<LatLng>> _savedPolylinesPoints = [];
  final List<List<LatLng>> _savedPolygonsPoints = [];
  List<List<LatLng>> _itineraryPoints = [];
  // List<Polygon> _savedPolygons = [];
  // Map markers only for the map places
  // var mapPlacesMarkers = <Marker>[];
  // markers for user current position and user places
  // var markers = <Marker>[];
  List<Marker> _markers = [];

  final GlobalKey<FabCircularMenuState> leftFabKey = GlobalKey();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  String? _serviceError = '';
  bool showBottomPlane = false;

  final Location _locationService = Location();

  var isLight = true;

  @override
  void initState() {
    super.initState();
    initLocationService();
  }

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  // void _addMarker(Point<double> point, LatLng coordinates) {
  //   setState(() {
  //     _markers.add(Marker(_rnd.nextInt(100000).toString(), coordinates, point,
  //         _addMarkerStates));
  //   });
  // }

  void initLocationService() async {
    bool serviceEnabled;

    try {
      var permission = await _locationService.requestPermission();
      _permission = permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited;

      await _locationService.requestService();
      serviceEnabled = await _locationService.serviceEnabled();

      var text = '';
      var title = '';

      debugPrint(
          '\n\n\n\n>>>>>><<<<<< initLocationService s:$serviceEnabled p:$_permission \n\n\n\n');

      if (!serviceEnabled) {
        title += '\nLocalisation Désactivée';
        text += '\nVeuillez activer votre localisation';
        await _locationService.requestService();
      }
      if (!_permission) {
        title += '\nPermission refusée';
        text += "\nL'application a besoin de votre localisation";
        await _locationService.requestPermission();
      }

      if (permission == PermissionStatus.deniedForever) {
        title = '\nPermission refusée pour toujours';
        text =
            "\n Vous avez désactivé l'accès à votre localisation pour cette application pour toujours\n Veuillez aller dans vos réglages et activer la permission pour utiliser l'application";
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  initLocationService();
                },
                child: const Text('Réessayer'),
              )
            ],
          ),
        );
        return;
      }

      if (!serviceEnabled || !_permission) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  initLocationService();
                },
                child: const Text('Réessayer'),
              )
            ],
          ),
        );

        initLocationService();
        return;
      }

      // permission = await _locationService.requestPermission();

      if (_permission && serviceEnabled) {
        await _locationService.changeSettings(
          accuracy: LocationAccuracy.high,
          interval: 1000,
        );
        //
        // if (!__appMounted) {
        _mapZoom = 17;
        // }

        _currentLocation = await _locationService.getLocation();
        setState(() {});
        debugPrint('\n\n\n>>>> _permission ');
        if (_currentLocation != null) {
          //
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              11.0,
              // LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              // _mapZoom);
            ),
          );
        }
        _locationService.onLocationChanged.listen((LocationData result) async {
          // if (mounted) {
          setState(() {
            _currentLocation = result;
            // If Live Update is enabled, move map center
            // if (_keepUserPositionInCenter) {
            if (_menuOpen) {
              //
            }
          });
          // }
        });
      }
    } on PlatformException catch (e) {
      debugPrint('>>>> eeror $e');
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
        // __snackbar('Permission refusée');
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
        // __snackbar('Impossible de déterminer le status de la localisation');
      }
      _currentLocation = null;
      initLocationService();
    }
  }

  _openMenu() {
    _menuOpen = true;
    setState(() {});
  }

  _closeMenu() {
    _menuOpen = true;
    setState(() {});
  }

  _toggleMenu() {
    _menuOpen = !_menuOpen;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    void _showSnackBar(BuildContext context, String message) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double _deviceWidth = screenWidth > 300 ? 300 : screenWidth;

    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.blueGrey)),
            //     Positioned.fill(
            //       child: MapboxMap(
            //         styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
            //         accessToken: ENV.ACCESS_TOKEN,
            //         trackCameraPosition: true,
            //         // onMapLongClick: _onMapLongClickCallback,
            //         // onCameraIdle: _onCameraIdleCallback,

            //         onMapCreated: _onMapCreated,
            //         initialCameraPosition:
            //             const CameraPosition(target: LatLng(0.0, 0.0)),
            //         onStyleLoadedCallback: _onStyleLoadedCallback,
            //         myLocationEnabled: true,
            //         myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            //         minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
            //         myLocationRenderMode: MyLocationRenderMode.NORMAL,
            //       ),
            //     ),
            //     // * Custom markers

            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              bottom: _menuOpen ? 0 : -100,
              left: 0,
              width: MediaQuery.of(context).size.width,
              // width: MediaQuery.of(context).size.width * .7,
              // left: MediaQuery.of(context).size.width *.15,
              height: 100,
              child: ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Place addd
                  AnimatedSlide(
                    offset: Offset(_menuOpen ? 0 : 2.09, 0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      tooltip: "Ajouter votre position actuelle",
                      heroTag: "##FAB._addPlace",
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        UIUtils.openModalBottomSheet(context,
                            view: AddPlaceView());
                      },
                      // child: Icon(Icons.add_location_alt_outlined),
                      child: const Icon(
                        FeatherIcons.flag,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  /// Search
                  AnimatedSlide(
                    offset: Offset(_menuOpen ? 0 : 1.09, 0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        tooltip: "Recherche",
                        heroTag: "##FAB._search",
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueGrey,
                        onPressed: () {
                          UIUtils.openModalBottomSheet(context,
                              view: SearchView());
                        },
                        child: const Icon(FeatherIcons.search)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  /// Main Button
                  __buildMainFAB(),
                  const SizedBox(
                    height: 5,
                  ),

                  /// Share Location
                  AnimatedSlide(
                    offset: Offset(_menuOpen ? 0 : -1.09, 0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tooltip: "Partager ma localisation",
                      heroTag: "##FAB._shareCurrent",
                      onPressed: () {
                        UIUtils.openModalBottomSheet(context,
                            view: SharePositionView());
                      },
                      child: const Icon(FeatherIcons.share2),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  /// User Profile Menu
                  AnimatedSlide(
                    offset: Offset(_menuOpen ? 0 : -2.09, 0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tooltip: "Profil",
                        heroTag: "##FAB._userProfile",
                        onPressed: () {
                          UIUtils.openModalBottomSheet(context,
                              view: UserProfileView());
                        },
                        child: const Icon(FeatherIcons.user)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              // Main button
              __buildMainFAB(),
            ]);
          },
        ));
  }

  /// Main FAB Button
  Widget __buildMainFAB() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Main Button
        FloatingActionButton(
          elevation: 0,
          tooltip: "Ajouter une nouvelle place",
          heroTag: "##FAB._togglePlaceAddingMode",
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            setState(() {
              _menuOpen = !_menuOpen;
              showBottomPlane = !showBottomPlane;
            });
          },
          child: AnimatedRotation(
              turns: _menuOpen ? 1 / 6 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutSine,
              child: const Icon(
                FeatherIcons.plus,
                size: 40,
              )),
        ),
      ],
    );
  }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  late double _x;
  late double _y;
  @override
  Offset getOffset({
    required Offset begin,
    required Offset end,
    required double progress,
  }) {
    _x = begin.dx + (end.dx - begin.dx) * progress;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x, _y);
  }

  @override
  Animation<double> getRotationAnimation({
    required Animation<double> parent,
  }) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({
    required Animation<double> parent,
  }) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}

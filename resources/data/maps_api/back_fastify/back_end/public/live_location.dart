import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LiveLocationPage extends StatefulWidget {
  static const String route = '/live_location';

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage>
    with TickerProviderStateMixin {
  LocationData? _currentLocation;
  LatLng currentLatLng = LatLng(0, 0);
  late final MapController _mapController;
  double _mapZoom = 5;
  bool _liveUpdate = true;
  bool _permission = false;

  List<LatLng> _points = [];
  List<LatLng> _ghostPoints = [];
  bool _showGhostPoints = false;

  List<List<LatLng>> _savedPolylinesPoints = [];
  List<List<LatLng>> _savedPolygonsPoints = [];
  List<Polygon> _savedPolygons = [];
  var markers = <Marker>[];

  var polygons = <Polygon>[];
  var polylines = <Polyline>[];

  String? _serviceError = '';

  var interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void didChangeDependencies() {
    initLocationService();
    super.didChangeDependencies();
  }

  void initLocationService() async {
    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      var permission = await _locationService.requestPermission();
      _permission = permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited;

      serviceRequestResult = await _locationService.requestService();
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
                child: Text('Réessayer'),
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
                child: Text('Réessayer'),
              )
            ],
          ),
        );

        initLocationService();
        return;
      }

      if (serviceEnabled) {
        // permission = await _locationService.requestPermission();

        if (_permission) {
          await _locationService.changeSettings(
            accuracy: LocationAccuracy.high,
            interval: 1000,
          );
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              _mapZoom = 18;
              setState(() {
                _currentLocation = result;
                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _animatedMapMove(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapZoom);

                  __snackbar('Mouvement détecté');
                }
              });
            }
          });
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
      initLocationService();
    }
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void __snackbar(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _deleteAllPoints() {
    debugPrint('>>> _deleteAllPoints');
    _points = [];
    _ghostPoints = [];
    setState(() {});
    __snackbar('Points supprimés ');
  }

  void _deleteLatestPoint() {
    debugPrint('>>> _deleteLatestPoint');
    if (_points.isEmpty) {
      __snackbar('Dernière position supprimée');
      return;
    }
    _points.removeLast();
    setState(() {});

    __snackbar('Dernière position supprimée');
  }

  void _validatePoints() {
    debugPrint('>>> _validatePoints');

    if (_points.length < 3) {
      //
      __snackbar('Veuillez ajouter au moins 3 points');
      return;
    }

    // close points loop
    _points.add(currentLatLng);
    _points.add(_points.first);
    _showGhostPoints = false;

    // save points n polygon
    _savedPolygonsPoints.add(_points);
    debugPrint('>>>>__savedPolygonsPoints $_savedPolygonsPoints');
    _points = [];
    _ghostPoints = [];
    // _savedPolygons.add(polygons.last);
    setState(() {});
    __snackbar('Sauvegardé!');
  }

  void _addCurrentPoint([LatLng? value]) {
    debugPrint('>>> _addCurrentPoint');
    _showGhostPoints = true;
    setState(() {});
    if (_currentLocation != null) {
      if (_currentLocation!.latitude != null &&
          _currentLocation!.longitude != null) {
        var point = value ??
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
        if (_points.contains(point)) {
          __snackbar('Position déja ajoutée');
          return;
        }

        _points.add(point);
        setState(() {});
        __snackbar('Position ajoutée');
        return;
      }
      __snackbar('Coordonnées non déterminées');
      return;
    }
    __snackbar('Position non déterminées');
    return;
  }

  void __mapOnTap(position, LatLng target) {
    debugPrint('>>> _mapOnTap');
    debugPrint(position.toString());
    debugPrint(target.toString());

    // _addCurrentPoint(target);
  }

  void _updateLayers() {
    polygons = [];
    // setup saved polygonPoints first
    for (var i = 0; i < _savedPolygonsPoints.length; i++) {
      var polygonMarker = Polygon(
        points: _savedPolygonsPoints[i],
        borderStrokeWidth: 1.5,
        borderColor: Colors.green.shade700,
        color: Colors.green,
      );
      polygons.add(polygonMarker);
      setState(() {});
    }

    polylines = [];

    markers = [];
    var mainMarker = Marker(
      width: 10.0,
      height: 10.0,
      point: currentLatLng,
      builder: (ctx) => Container(
        width: 3,
        height: 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ]
            // border: BorderSide.
            ),
      ),
    );
    // Add base points n layers
    markers.add(mainMarker);

    if (_points.isNotEmpty) {
      // first point marker
      var firstPointMarker = Marker(
        width: 10.0,
        height: 10.0,
        point: _points[0],
        builder: (ctx) => Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.red,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 1),
                ),
              ]
              // border: BorderSide.
              ),
        ),
      );
      markers.add(firstPointMarker);

      if (_points.length > 1) {
        var polylineMarker = Polyline(
          points: _points,
          color: Colors.purple,
          strokeWidth: 2,
        );
        polylines.add(polylineMarker);
      }
      if (_points.length >= 3 && !_showGhostPoints) {
        // draw the polygon
        var polygonMarker = Polygon(
          points: _points,
          borderStrokeWidth: 2,
          borderColor: Colors.blue.shade700,
          color: Colors.blue,
        );
        polygons.add(polygonMarker);
      }
      // draw ghost line
      _ghostPoints = [];
      if (_showGhostPoints) {
        if (currentLatLng != _points.last) {
          _ghostPoints.add(_points.last);
          _ghostPoints.add(currentLatLng);

          // draw polyline
          var polylineMarker = Polyline(
              points: _ghostPoints,
              color: Colors.purple,
              isDotted: true,
              strokeWidth: 3);
          polylines.add(polylineMarker);

          if (_points.length > 1) {
            // draw last first polyline
            var polylineMarker = Polyline(
                points: [currentLatLng, _points.first],
                color: Colors.red,
                isDotted: true,
                strokeWidth: 2);
            polylines.add(polylineMarker);
          }
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    _updateLayers();

    return Scaffold(
      appBar: AppBar(title: Text('Accueil')),
      // drawer: buildDrawer(context, LiveLocationPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                    'Position actuelle: \nlat: ${_currentLocation?.latitude}\n lon: ${_currentLocation?.longitude}\n alt: ${_currentLocation?.longitude} \n prec: ${_currentLocation?.accuracy}m\n direction: ${_currentLocation?.heading}°\n precision direction: ${_currentLocation?.headingAccuracy}  \n vitesse: ${_currentLocation?.speed}m/s\n precision vitesse: ${_currentLocation?.speedAccuracy} \n satellites: ${_currentLocation?.satelliteNumber}\n  reseau: ${_currentLocation?.provider}\n  heure: ${_currentLocation?.time}  ')),
            if (_serviceError!.isNotEmpty)
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text('Erreur de localisation  : '
                      '$_serviceError')),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                    center:
                        LatLng(currentLatLng.latitude, currentLatLng.longitude),
                    zoom: _mapZoom,
                    maxZoom: 18,
                    interactiveFlags: interActiveFlags,
                    onTap: __mapOnTap),
                layers: [
                  // TileLayerOptions(

                  //   urlTemplate:
                  //       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //   subdomains: ['a', 'b', 'c'],
                  //   // For example purposes. It is recommended to use
                  //   // TileProvider with a caching and retry strategy, like
                  //   // NetworkTileProvider or CachedNetworkTileProvider
                  //   // tileProvider: NonCachingNetworkTileProvider(),

                  // ),
                  // TileLayerOptions(
                  //   urlTemplate:
                  //       'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiLWEtYS0iLCJhIjoiY2twaTd2Ym5nMDc2bTJwcG52Zzg5YWw1bCJ9.Vkws2QfR0bUq3PI4dd-9Kw',
                  // ),
                  TileLayerOptions(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/naf94/ckhhopnxn2go319nu282fi710/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmFmOTQiLCJhIjoiY2s5Y21nMzNjMDA3cTNlczUxNTU4Y2s0YiJ9.KduEUSPHqfHmsjg5EQAKpw',
                    tileProvider: NetworkTileProvider(),
                  ),
                  PolygonLayerOptions(polygons: polygons),
                  PolylineLayerOptions(polylines: polylines),
                  MarkerLayerOptions(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                backgroundColor: _points.isNotEmpty ? Colors.red : Colors.grey,
                onPressed: _deleteAllPoints,
                child: Icon(
                  Icons.delete,
                )),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
                onPressed: _deleteLatestPoint,
                backgroundColor: _points.isNotEmpty ? Colors.blue : Colors.grey,
                child: Icon(
                  Icons.undo,
                )),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
                backgroundColor:
                    _currentLocation != null ? Colors.blue : Colors.grey,
                onPressed: _addCurrentPoint,
                child: Icon(
                  Icons.add_location,
                )),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
                backgroundColor:
                    _points.length > 2 ? Colors.green : Colors.grey,
                onPressed: _validatePoints,
                child: Icon(
                  Icons.done,
                )),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _liveUpdate = !_liveUpdate;

                  if (_liveUpdate) {
                    interActiveFlags = InteractiveFlag.rotate |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom;
                    __snackbar('Mode tracking activé');
                  } else {
                    interActiveFlags = InteractiveFlag.all;
                    __snackbar('Mode tracking désactivé');
                  }
                });
              },
              child: _liveUpdate
                  ? Icon(Icons.gps_fixed)
                  : Icon(Icons.gps_not_fixed),
            ),
          ],
        );
      }),
    );
  }
}

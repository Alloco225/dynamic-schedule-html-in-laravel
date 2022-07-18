// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/ici_place.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon_chip.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class PlaceDetailSheet extends StatefulWidget {
//   final IciPlace place;
//   PlaceDetailSheet({required this.place});

//   @override
//   _PlaceDetailSheetState createState() => _PlaceDetailSheetState();
// }

// class _PlaceDetailSheetState extends State<PlaceDetailSheet> {
//   late final TextEditingController _searchInputController;
//   late final FocusNode _searchFocusNode;
//   late final MapDataController mapDataController;

//   // Coordinates math
//   late final Geodesy geodesy;

//   //
//   bool _showMore = false;
//   bool _isSearching = false;

//   @override
//   void initState() {
//     // Initialisations
//     mapDataController = Get.find();
//     _searchInputController = TextEditingController();
//     _searchFocusNode = FocusNode();
//     geodesy = Geodesy();

//     // Focus on Input
//     Future.delayed(Duration(seconds: 2))
//         .then((value) => _searchFocusNode.requestFocus());
//     super.initState();
//   }

//   _placeTypeIcon(IciPlace place) {
//     return Icons.directions;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // num dist = geodesy.distanceBetweenTwoGeoPoints(
//     //     widget.place.latLng!, mapDataController.currentPosition.value);
//     // int distance = dist.floor();
//     // String distanceText =
//     //     distance > 1000 ? "${distance / 1000} km" : "$distance m";
//     // String distanceText = "$dist";

//     return makeDismissible(
//         context: context,
//         child: DraggableScrollableSheet(
//           initialChildSize: .6,
//           builder: (_, controller) => Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//             ),
//             child: ListView(
//               controller: controller,
//               children: [
//                 //
//                 AGrappler(),

//                 // Search result main infos
//                 ListTile(
//                   leading: InkWell(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                     ),
//                   ),
//                   title: Text("${widget.place.display_name ?? '[Aucun Nom]'}"),
//                   subtitle: Text("${widget.place.city_code}"),
//                   trailing: AIcon(
//                     icon: _placeTypeIcon(widget.place),
//                     color: Colors.deepOrange,
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       if (widget.place.coords!.isNotEmpty)
//                         Text("${widget.place.coords}"),
//                       // Text("Distance : $distanceText"),
//                     ],
//                   ),
//                 ),
//                 Divider(height: 10),
//                 // Search result images
//                 if (widget.place.images?.isNotEmpty ?? false)
//                   widget.place.images!.length > 0
//                       ? Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: CarouselSlider(
//                             options: CarouselOptions(
//                               autoPlay: true,
//                               height: 150,
//                               viewportFraction: .5,
//                             ),
//                             items: widget.place.images!
//                                 .map((img) => Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 3),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Center(
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           child: Image.network(img.toString()),
//                                         ),
//                                       ),
//                                     ))
//                                 .toList(),
//                           ),
//                         )
//                       : Container(
//                           height: 50,
//                           width: 50,
//                           constraints: BoxConstraints(
//                             maxWidth: 50,
//                             maxHeight: 50,
//                           ),
//                           // color: Colors.red,
//                           child: InkWell(
//                             child: Center(
//                               child: Icon(
//                                 Icons.add,
//                               ),
//                             ),
//                           ),
//                         ),
//                 // Search result actions
//                 // Container(
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //       crossAxisAlignment: CrossAxisAlignment.center,
//                 //       children: <Widget>[
//                 //         _navButton(
//                 //             Icons.add, Colors.blue, () => _addNewPlace(place)),
//                 //         _navButton(Icons.directions, Colors.red, _openCodeGenerationSheet),
//                 //         _navButton(Icons.share, Colors.green, () {
//                 //           // Share location
//                 //           _shareLocation("Abidjan place");
//                 //         }),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

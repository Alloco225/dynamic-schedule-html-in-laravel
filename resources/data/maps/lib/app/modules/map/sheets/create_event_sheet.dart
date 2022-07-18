// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/ici_place.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon_chip.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class CreateEventSheet extends StatefulWidget {
  
//   CreateEventSheet();

//   @override
//   _PlaceDetailSheetState createState() => _PlaceDetailSheetState();
// }

// class _PlaceDetailSheetState extends State<CreateEventSheet> {
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

//   @override
//   Widget build(BuildContext context) {
//     // num dist = geodesy.distanceBetweenTwoGeoPoints(
//     //     selectedPlace.latLng!, _currentPosition);
//     // int distance = dist.floor();
//     // String distanceText =
//     //     distance > 1000 ? "${distance / 1000} km" : "$distance m";
//     //
//     //
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
//                 // AGrappler(
//                 //   marginTop: 40,
//                 //   marginBottom: 30,
//                 // ),
//                 SizedBox(height: 50),
//                 // SearchBar

//                 SizedBox(height: 10),
//                 //
//                 Divider(
//                   color: Colors.grey,
//                   height: 0,
//                 ),

//                 // Place types Show more

//                 //
//                 AGrappler(),
//                 Text("Creer un nouvel evenement")
//               ],
//             ),
//           ),
//         ));
//   }
// }

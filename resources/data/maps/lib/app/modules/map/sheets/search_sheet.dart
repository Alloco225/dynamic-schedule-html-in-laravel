

// class SearchSheet extends StatefulWidget {
//   SearchSheet({Key? key}) : super(key: key);

//   @override
//   _SearchSheetState createState() => _SearchSheetState();
// }

// class _SearchSheetState extends State<SearchSheet> {
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
//   void dispose() {
//     // TODO: implement dispose

//     _searchInputController.dispose();
//     _searchFocusNode.dispose();
//     // mapDataController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //
//     return DraggableScrollableSheet(
//       initialChildSize: 1,
//       builder: (_, controller) => Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//         ),
//         child: ListView(
//           controller: controller,
//           children: [
//             // AGrappler(
//             //   marginTop: 40,
//             //   marginBottom: 30,
//             // ),
//             SizedBox(height: 50),
//             // SearchBar
//             Container(
//               width: MediaQuery.of(context).size.width * .8,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 controller: _searchInputController,
//                 focusNode: _searchFocusNode,
//                 onChanged: (value) {
//                   if (value.length > 3) {
//                     mapDataController.searchPlaces(value);
//                   }
//                 },
//                 // onSubmitted: _searchSubmitted,
//                 onEditingComplete: () {
//                   // _searchFocusNode.unfocus();
//                   // _pageMode = PageMode.Home;
//                   // setState(() {});
//                 },
//                 expands: false,
//                 decoration: InputDecoration(
//                   hintText: "Rechercher",
//                   border: InputBorder.none,
//                   // focusColor: Colors.grey[100],
//                   // fillColor: Colors.grey[100],

//                   prefixIcon: InkWell(
//                     child: Icon(
//                       _searchFocusNode.hasFocus ? Icons.close : Icons.search,
//                     ),
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             //
//             Divider(
//               color: Colors.grey,
//               height: 0,
//             ),

//             // Place types
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               color: Colors.grey[50],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ...mapDataController.placeCategories
//                       .take(mapDataController.placeCategories.length > 4
//                           ? 4
//                           : mapDataController.placeCategories.length)
//                       .map(
//                         (placeCategory) => AIconChip(
//                           label: placeCategory.name,
//                           color: Colors.grey[400],
//                           icon: placeCategory.icon ?? Icons.place,
//                           onTap: () {
//                             //
//                           },
//                         ),
//                       )
//                       .toList(),
//                   if (mapDataController.placeCategories.length > 4)
//                     AIconChip(
//                       label: _showMore ? "Moins" : "Plus",
//                       icon: _showMore ? Icons.close : Icons.more_horiz,
//                       color: Colors.grey,
//                       onTap: () {
//                         //
//                         _showMore = !_showMore;
//                         setState(() {});
//                       },
//                     ),
//                 ],
//               ),
//             ),

//             // Place types Show more
//             if (_showMore)
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 color: Colors.grey[50],
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ...mapDataController.placeCategories
//                         .skip(4)
//                         .take(mapDataController.placeCategories.length - 4 > 5
//                             ? 5
//                             : mapDataController.placeCategories.length)
//                         .map(
//                           (placeCategory) => AIconChip(
//                             label: placeCategory.name,
//                             color: Colors.grey[400],
//                             icon: placeCategory.icon ?? Icons.place,
//                             onTap: () {
//                               //
//                             },
//                           ),
//                         )
//                         .toList(),
//                   ],
//                 ),
//               ),

//             //
//             Divider(
//               color: Colors.grey,
//               height: 0,
//             ),
//             SizedBox(height: 10),

//             // Favorite places
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               height: 50,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   //
//                   AFavoritePlace(
//                     name: "Travail",
//                     value: "Non défini",
//                     icon: Icons.work,
//                   ),
//                   AFavoritePlace(
//                     name: "Ecole",
//                     value: "Esma",
//                     icon: Icons.school,
//                   ),
//                   ...mapDataController.savedPlaces
//                       .map(
//                         (savedPlace) => AFavoritePlace(
//                           name: savedPlace.label,
//                           icon: Icons.flag,
//                           onTap: () {
//                             //
//                             showTopSnackBar(
//                               context,
//                               CustomSnackBar.info(
//                                 message:
//                                     "There is some information. You need to do something with that",
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                       .toList(),
//                   AFavoritePlace(
//                     name: "Voir tout",
//                     icon: Icons.more_horiz,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             Divider(
//               color: Colors.grey,
//               height: 0,
//             ),
//             SizedBox(height: 10),

//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Icon(Icons.history),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Historique"),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             // Recent searches
//             mapDataController.isSearchLoading.value
//                 ? Center(child: CircularProgressIndicator())
//                 : Container(),

//             Obx(
//               () => Column(
//                 children: mapDataController.placeSearchResults.map((result) {
//                   num dist = geodesy.distanceBetweenTwoGeoPoints(
//                     LatLng(result.lat!, result.lon!),
//                     mapDataController.currentPosition.value,
//                   );
//                   int distance = dist.floor();
//                   String distanceText =
//                       distance > 1000 ? "${distance / 1000} km" : "$distance m";
//                   //
//                   return ListTile(
//                     dense: true,
//                     tileColor: Colors.white,
//                     leading: Icon(Icons.location_on),
//                     title: Text("${result.displayName}"),
//                     trailing: Text("$distanceText"),
//                     onTap: () {
//                       //
                      
//                       Navigator.of(context).pop();

//                       print(">> result tap");
//                       // __mapGoTo(LatLng(result.lat!, result.lon!));
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//             //
//             // ListTile(
//             //   dense: true,
//             //   tileColor: Colors.white,
//             //   leading: Icon(
//             //     Icons.location_on_outlined,
//             //     size: 40,
//             //   ),
//             //   title: Text("Abidjan lagunes"),
//             //   trailing: Text("5.2 Km"),
//             //   onTap: () {
//             //     //
//             //     print(">> result tap");
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AFavoritePlace extends StatelessWidget {
//   final VoidCallback? onTap;
//   final IconData? icon;
//   final String name;
//   final String? value;

//   AFavoritePlace({
//     this.onTap,
//     this.icon,
//     required this.name,
//     this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.grey[400],
//                 foregroundColor: Colors.white,
//                 radius: 18,
//                 child: Icon(
//                   icon ?? Icons.location_on,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("$name"),
//                   if (value != null) Text("$value"),
//                 ],
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           margin: EdgeInsets.symmetric(horizontal: 5),
//         ),
//       ),
//     );
//   }
// }

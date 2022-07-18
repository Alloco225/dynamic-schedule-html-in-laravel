// import 'package:flutter/material.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon_chip.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class UserProfileSheet extends StatefulWidget {
//   UserProfileSheet({Key? key}) : super(key: key);

//   @override
//   _UserProfileSheetState createState() => _UserProfileSheetState();
// }

// class _UserProfileSheetState extends State<UserProfileSheet> {
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
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "${mapDataController.user.value.profile_picture}"),
//                 ),
//                 title: Text("${mapDataController.user.value.name}"),
//                 subtitle: Text("${mapDataController.user.value.phone}"),
//                 trailing: Icon(
//                   Icons.edit_outlined,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             //
//             Divider(
//               color: Colors.grey,
//               height: 0,
//             ),

//             // Options list
//             ListTile(
//               leading: Icon(Icons.home_outlined),
//               title: Text("Maison"),
//               subtitle: Text(
//                 "Non défini",
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.work_outline),
//               title: Text("Travail"),
//               subtitle: Text(
//                 "Non défini",
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.event_outlined),
//               title: Text("Mes Events"),
              
//             ),
//             // Recent places

//             // Favorite places
//             // ListTile(
//             //   leading: Icon(Icons.work_outline),
//             //   title: Text("Maison"),
//             //   subtitle: Text(
//             //     "Non défini",
//             //   ),
//             // ),

//             Spacer(),

//             // Settings
//             ListTile(
//               leading: Icon(Icons.settings_outlined),
//               title: Text("Réglages"),
//             ),

//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }

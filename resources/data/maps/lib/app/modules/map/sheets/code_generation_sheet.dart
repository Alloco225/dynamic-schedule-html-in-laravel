// import 'package:clipboard/clipboard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/nominatim_place.dart';
// import 'package:ici/src/models/user.dart';
// import 'package:ici/src/screens/sheets/authentication_sheet.dart';
// import 'package:ici/src/services/remote/api/maps_api.dart';
// import 'package:ici/src/utils/utils.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import '../../utils/open-location-code.dart' as openLocation;

// class CodeGenerationSheet extends StatefulWidget {
//   final LatLng position;
//   final NominatimPlace nominatimPlace;

//   CodeGenerationSheet({
//     Key? key,
//     required this.position,
//     required this.nominatimPlace,
//   }) : super(key: key);

//   @override
//   _CodeGenerationSheetState createState() => _CodeGenerationSheetState();
// }

// class _CodeGenerationSheetState extends State<CodeGenerationSheet> {
//   //
//   String addressCode = "";
//   bool _isLoading = true;
//   bool isEphemere = false;
//   bool isPrivate = false;
//   bool _isCodeLoading = false;

//   late MapDataController mapDataController;

//   //
//   late String? displayName;
//   late String? address;

//   _generateCode() async {
//     print("<< _generateCode");
//     _isCodeLoading = true;
//     setState(() {});

//     // get pluscode
//     String plusCode = openLocation.encode(
//         widget.position.latitude, widget.position.longitude);

//     User user = mapDataController.user.value;

//     if (user.id == "") {
//       // If no auth
//       showTopSnackBar(
//         context,
//         CustomSnackBar.info(
//           message: "Veuillez vous connecter pour générer un code",
//         ),
//       );
//       await Future.delayed(Duration(seconds: 2));
//       // open auth sheet to
//       await openModalBottomSheet(context,
//           view: AuthenticationSheet(
//             initAuthMode: AuthMode.Login,
//           ));

//       // if not auth
//       if (mapDataController.user.value.id == "") {
//         showTopSnackBar(
//           context,
//           CustomSnackBar.info(
//             message: "Nous n'avons pas pu vous connecter.\n Veuillez réessayer",
//           ),
//         );
//         _isCodeLoading = false;
//         setState(() {});
//         return;
//       }
//       // await for result
//     }

//     user = mapDataController.user.value;

//     Map data = {
//       "user": user.toJson(),
//       "is_ephemere": isEphemere,
//       "is_private": isPrivate,
//       "plus_code": plusCode,
//       "location": widget.nominatimPlace.toJson(),
//     };

//     print("<< data");
//     print(data);

//     // Make api call
//     try {
//       print(">> Remote:generateAddressCode");
//       addressCode = await MapsRemoteApiService.generateAddressCode(data);
//     } catch (e) {
//       //
//       showTopSnackBar(
//         context,
//         CustomSnackBar.info(
//           message: e.toString(),
//         ),
//       );
//     }
//     //
//     _isCodeLoading = false;
//     setState(() {});
//   }

//   _init() async {
//     _isLoading = true;
//     mapDataController = Get.find<MapDataController>();
//     displayName = widget.nominatimPlace.display_name;
//     address = widget.nominatimPlace.address?.state ?? "";
//     address = address! + (widget.nominatimPlace.address?.city ?? "");
//     // fetch location details
//     _isLoading = false;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     print("<<** CodeGeneration sheet");

//     _init();
//   }


//   _share() async {
//           //
//           await Share.share('$addressCode');
//           // FlutterClipboard.copy(addressCode).then(
//           //     (value) => print("copied")
//           //     // InAppNotification.show(
//           //     //       child: ANotification("Copié"),
//           //     //       context: context,

//           //     //       onTap: () => print('Notification tapped!'),
//           //     //     )
//           //     );
//         // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       // initialChildSize: .4,

//       initialChildSize: .5,

//       builder: (c, sc) => Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//         ),
//         child: ListView(
//           // mainAxisSize: MainAxisSize.min,
//           // mainAxisAlignment: MainAxisAlignment.start,
//           controller: sc,
//           children: _isLoading
//               ? [
//                   AGrappler(),
//                   Spacer(),
//                   Center(child: CircularProgressIndicator()),
//                   Spacer(),
//                 ]
//               : [
//                   AGrappler(),

//                   // TitleBox
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10)),
//                     child: ListTile(
//                       dense: true,
//                       title: Text("$displayName"),
//                       subtitle: Text("$address"),
//                       trailing: AIcon(
//                         icon: Icons.place,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),

//                   Divider(
//                     height: 20,
//                   ),

//                   //
//                   // Code Item
//                   // Code settings
//                   if (addressCode.isEmpty)
//                     ListTile(
//                       leading: AIcon(
//                         color: isEphemere ? Colors.orange : Colors.grey,
//                         icon: Icons.alarm,
//                       ),
//                       title: Text("Ephémère"),
//                       subtitle: Text("Le code sera valide que pour 15 minutes"),
//                       trailing: CupertinoSwitch(
//                         value: isEphemere,
//                         onChanged: (_) {
//                           isEphemere = _;
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   if (addressCode.isEmpty)
//                     Divider(
//                       height: 20,
//                     ),
//                   if (addressCode.isEmpty)
//                     ListTile(
//                       leading: AIcon(
//                         color: isPrivate ? Colors.purple : Colors.grey,
//                         icon: isPrivate ? Icons.lock : Icons.lock_open,
//                         animated: true,
//                       ),
//                       title: Text("Privée"),
//                       subtitle: Text(
//                           "Vous recevrez une demande avant d'afficher le code à un tiers"),
//                       trailing: CupertinoSwitch(
//                         value: isPrivate,
//                         onChanged: (_) {
//                           isPrivate = _;
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   if (addressCode.isEmpty)
//                     Divider(
//                       height: 20,
//                     ),

//                   if (addressCode.isNotEmpty)
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("$addressCode"),
//                           IconButton(
//                             icon: Icon(Icons.share),
//                             onPressed: _share,
//                           ),
//                         ],
//                       ),
//                     ),
//                   if (addressCode.isEmpty)
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Spacer(),
//                           _isCodeLoading
//                               ? CircularProgressIndicator()
//                               : Expanded(
//                                   flex: 2,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ElevatedButton(
//                                       onPressed: _generateCode,
//                                       child: Text(
//                                         "Générer",
//                                         textScaleFactor: 1.5,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                           Spacer(),
//                         ],
//                       ),
//                     ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   // Action buttons
//                   if (addressCode.isNotEmpty)
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[],
//                         ),
//                       ),
//                     ),
//                 ],
//         ),
//       ),
//     );
//   }
// }

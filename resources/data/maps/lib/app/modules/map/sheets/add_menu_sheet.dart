// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/ici_place.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon_chip.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:intl/intl.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class AddMenuSheet extends StatefulWidget {
//   AddMenuSheet();

//   @override
//   _PlaceDetailSheetState createState() => _PlaceDetailSheetState();
// }

// class _PlaceDetailSheetState extends State<AddMenuSheet> {
//   late final TextEditingController _searchInputController;
//   late final FocusNode _searchFocusNode;
//   late final MapDataController mapDataController;

//   // Coordinates math

//   late final Geodesy geodesy;
//   //
//   bool _showMore = false;
//   bool _isLoading = true;

//   Map _newPlaceData = {
//     'display_name': '',
//     'place_type': '',
//     'bbox': [],
//     'lat': '',
//     'lon': '',
//     'creator_key': '',
//   };

//   double? _modalInitialSize = .2;

//   final _formKey = GlobalKey<FormBuilderState>();

//   @override
//   void initState() {
//     super.initState();
//     // Initialisations
//     mapDataController = Get.find();
//     _searchInputController = TextEditingController();
//     _searchFocusNode = FocusNode();
//     geodesy = Geodesy();

//     // Focus on Input
//     Future.delayed(Duration(seconds: 1)).then((value) {
//       _searchFocusNode.requestFocus();

//       _modalInitialSize = null;
//       _isLoading = false;
//       setState(() {});
//     });
//   }

//   //
//   _submit() {
//     print(">>> _submit()");
//     _formKey.currentState!.validate();
//     Map data = _formKey.currentState!.value;
//     //
//     print(data);
//     // api request
//     // update
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
//       context: context,
//       child: FractionallySizedBox(
//         heightFactor: _modalInitialSize,
//         child: DraggableScrollableSheet(
//           initialChildSize: .6,
//           minChildSize: .2,
//           builder: (_, _sheetScrollController) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15)),
//               ),
//               child: ListView(
//                 controller: _sheetScrollController,
//                 children: [
//                   AGrappler(),
//                   if (_isLoading)
//                     Container(
//                       height: MediaQuery.of(context).size.height * .1,
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     ),
//                   if (!_isLoading) ..._buildView(),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   _buildView() {
//     return [
//       // TitleBox
//       ListTile(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//           ),
//           onPressed:
//               // _gotoHomeScreen,
//               () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text("Ajouter un lieu"),
//         subtitle: Text("Choisissez ce que vous voyez"),
//         trailing: AIcon(
//           color: Colors.green,
//           icon: Icons.settings,
//         ),
//       ),

//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FormBuilder(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             children: <Widget>[
//               FormBuilderTextField(
//                 name: 'display_name',
//                 decoration: InputDecoration(
//                   labelText: "Nom du lieu",
//                 ),

//                 // valueTransformer: (text) => num.tryParse(text),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(context, errorText: "Vous avez oublié le nom du lieu"),
//                 ]),
//                 keyboardType: TextInputType.streetAddress
//               ),
//               // FormBuilderFilterChip(
//               //   name: 'place_options',
//               //   decoration: InputDecoration(
//               //     labelText: 'Select many options',
//               //   ),
//               //   options: mapDataController.placeCategories.value
//               //       .map(
//               //         (cat) => FormBuilderFieldOption(
//               //           key: Key("${cat.id}"),
//               //           value: cat.name,
//               //           child: Container(
//               //             child: Icon(cat.icon),
//               //             margin: EdgeInsets.only(right: 2),
//               //           ),
//               //         ),
//               //       )
//               //       .toList(),
//               // ),
//               FormBuilderChoiceChip(
//                 name: 'place_type',
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(context,
//                       errorText: "Ajouter un type pour le lieu"),
//                 ]),
//                 decoration: InputDecoration(
//                   labelText: "Type de lieu",
//                   border: InputBorder.none,
//                 ),

//                 onSaved: (data) {
//                   print(">> place_type $data");
//                 },
//                 options: mapDataController.placeCategories.value
//                     .map(
//                       (cat) => FormBuilderFieldOption(
//                         key: Key("${cat.id}"),
//                         value: cat.name,
//                         child: Container(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text("${cat.name}"),
//                               SizedBox(width: 5),
//                               Icon(cat.icon),
//                             ],
//                           ),
//                           margin: EdgeInsets.only(right: 2),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),

//             ],
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: MaterialButton(
//                 color: Theme.of(context).accentColor,
//                 child: Text(
//                   "Submit",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   _formKey.currentState!.save();
//                   if (_formKey.currentState!.validate()) {
//                     print(_formKey.currentState!.value);
//                   } else {
//                     print("validation failed");
//                   }
//                 },
//               ),
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: MaterialButton(
//                 color: Theme.of(context).accentColor,
//                 child: Text(
//                   "Reset",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   _formKey.currentState!.reset();
//                 },
//               ),
//             ),
//           ],
//         ),
//       )
//     ];
//   }
// }

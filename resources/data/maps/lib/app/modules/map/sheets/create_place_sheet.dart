// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/models/NominatimPlaceResult.dart';
// import 'package:ici/src/models/nominatim_place.dart';
// import 'package:ici/src/models/user.dart';
// import 'package:ici/src/services/remote/api/maps_api.dart';
// import 'package:ici/src/utils/utils.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/ici_place.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/a_icon_chip.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:intl/intl.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:ici/src/models/http_exception.dart';
// import 'authentication_sheet.dart';

// class CreatePlaceSheet extends StatefulWidget {
//   final LatLng point;
//   final String? plusCode;
//   final List? bbox;
//   CreatePlaceSheet({required this.point, this.plusCode, this.bbox = const []});

//   @override
//   _PlaceDetailSheetState createState() => _PlaceDetailSheetState();
// }

// class _PlaceDetailSheetState extends State<CreatePlaceSheet> {
//   late final MapDataController mapDataController;

//   // Coordinates math

//   late final Geodesy geodesy;
//   //
//   bool _showMore = false;
//   bool _isLoading = true;
//   bool _isSubmitting = false;

//   NominatimPlace? nominatimPlace;

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
//   late final NominatimPlaceResult nominatimPlaceResult;

//   @override
//   void initState() {
//     super.initState();
//     // Initialisations
//     mapDataController = Get.find();
//     geodesy = Geodesy();

//     _init();
//   }

//   _init() async {
//     // Fetch location information
//     //
//     nominatimPlace = await MapsRemoteApiService.reverseSearch(
//         widget.point.latitude, widget.point.longitude);

//     _modalInitialSize = null;
//     _isLoading = false;
//     setState(() {});
//   }

//   //
//   _submit() async {
//     print(">>> _submit()");
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

//         setState(() {});
//         return;
//       }
//       // await for result
//     }

//     _formKey.currentState!.save();
//     if (!_formKey.currentState!.validate()) return;
//     //
//     print(">>>>>>> form validated !!");
//     Map data = {};
//     // data['input'] = _formKey.currentState!.value;

//     data["display_name"] = _formKey.currentState!.value['display_name'];
//     data["latitude"] = widget.point.latitude;
//     data["longitude"] = widget.point.longitude;
//     data["author_key"] = mapDataController.user.value.id;
//     data["place_type"] = _formKey.currentState!.value['place_type'];
//     data["pictures"] = [];
//     data["plus_code"] = widget.plusCode;
//     data["bbox"] = widget.bbox;
//     data["country_code"] = nominatimPlace?.address?.country_code ?? "ci";
//     //
//     data['nominatim_place'] = nominatimPlace?.toJson() ?? null;

//     print(data);
//     // api request
//     _isSubmitting = true;
//     setState(() {});
//     try {
//       bool result = await mapDataController.submitNewPlace(data);
//       print("<<<<<<<<<<<");
//       print(result);

//       if (result) {
//         showTopSnackBar(
//           context,
//           CustomSnackBar.success(
//             message: "${data['display_name']} enregistré",
//           ),
//         );
//         _isSubmitting = false;
//         setState(() {});
//         Navigator.of(context).pop(true);
//       }
//     } catch (e) {
//       showTopSnackBar(
//         context,
//         CustomSnackBar.error(
//           message: e.toString(),
//         ),
//       );
//     }

//     // update
//   }

//   @override
//   Widget build(BuildContext context) {
//     // num dist = geodesy.distanceBetweenTwoGeoPoints(
//     //     selectedPlace.point!, _currentPosition);
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
//       Container(
//         padding: const EdgeInsets.all(8.0),
//         child: Text("Ajouter un lieu", textAlign: TextAlign.center),
//       ),
//       if (nominatimPlace == null)
//         Container(
//           padding: const EdgeInsets.all(8.0),
//           child: Text("${widget.point.latitude}, ${widget.point.longitude}"),
//         ),
//       if (nominatimPlace != null)
//         Container(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text("${nominatimPlace?.display_name}"),
//             ],
//           ),
//         ),
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
//                   FormBuilderValidators.required(
//                     context,
//                     errorText: "Nom requis",
//                   ),
//                 ]),
//                 keyboardType: TextInputType.streetAddress,
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
//                 decoration: InputDecoration(
//                   labelText: "Type de lieu",
//                   border: InputBorder.none,
//                 ),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(
//                     context,
//                     errorText: "Ajoutez un type",
//                   ),
//                 ]),
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
//               // TextButton(
//               //   child: Text("Ajouter un type de lieu"),
//               //   onPressed: () {
//               //     openModalBottomSheet(context, view: DraggableScrollableSheet(
//               //       builder: (ctx, s) => Container(
//               //         child: TextField(),
//               //       ),
//               //     ),);
//               //   },
//               // )
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
//                 child: _isSubmitting
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : Text(
//                         "Envoyer",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                 onPressed: _isSubmitting ? null : () => _submit(),
//               ),
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: MaterialButton(
//                 color: Theme.of(context).accentColor,
//                 child: Text(
//                   "Annuler",
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

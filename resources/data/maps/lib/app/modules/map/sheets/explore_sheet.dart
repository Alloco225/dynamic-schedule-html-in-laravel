// import 'package:clipboard/clipboard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geodesy/geodesy.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/env/theme.dart';
// import 'package:ici/src/models/ici_events.dart';
// import 'package:ici/src/models/user.dart';
// import 'package:ici/src/screens/pages/event_categories_selection_page.dart';
// import 'package:ici/src/screens/pages/event_detail_page.dart';
// import 'package:ici/src/screens/sheets/create_event_sheet.dart';
// import 'package:ici/src/utils/utils.dart';
// import 'package:ici/src/widgets/a_event_card.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// import 'authentication_sheet.dart';

// class ExploreSheet extends StatefulWidget {
//   @override
//   _ExploreSheetState createState() => _ExploreSheetState();
// }

// class _ExploreSheetState extends State<ExploreSheet> {
//   //
//   late AuthMode _authMode;
//   late PageController _pageController;

//   late final TextEditingController _searchInputController;
//   late final FocusNode _searchFocusNode;
//   late final MapDataController mapDataController;
//   late final Geodesy geodesy;

//   late String _date;
//   late String _userName;
//   late String _userProfilePicture;

//   var format = DateFormat.yMMMd('fr');

//   @override
//   void initState() {
//     print("** Explore sheet **");
//     _authMode = AuthMode.Register;
//     _pageController = PageController(initialPage: 0);

//     mapDataController = Get.find();
//     _searchInputController = TextEditingController();
//     _searchFocusNode = FocusNode();
//     geodesy = Geodesy();

//     _initPage();

//     _date = format.format(DateTime.now());

//     // format

//     super.initState();
//     setState(() {});
//   }

//   _initPage() async {
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
//   }
//   //

//   List categories = [
//     "All",
//     "Business",
//     "Art et culture",
//     "Musique",
//     "Festival",
//     "Concert",
//   ];
//   List selectedCategories = [];

//   @override
//   void didChangeDependencies() {
//     print("<<< digChangeDep");

//     super.didChangeDependencies();
//     // showModalBottomSheet(
//     //   context: context,
//     //   isScrollControlled: true,
//     //   backgroundColor: Colors.transparent,
//     //   shape: RoundedRectangleBorder(
//     //       borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//     //   builder: (ctx) => EventCategoriesSelectionPage(),
//     // );

//     // Future.delayed(Duration(seconds: 2)).then((_) => _setUpCategories());
//   }

//   _setUpCategories() async {
//     await Navigator.of(context).push(
//         MaterialPageRoute(builder: (ctx) => EventCategoriesSelectionPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     User _user = mapDataController.user.value;

//     return makeDismissible(
//       context: context,
//       child: DraggableScrollableSheet(
//         initialChildSize: 1,
//         minChildSize: .3,
//         builder: (_, controller) => Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFf5f0e1),
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//           ),
//           child: Column(
//             children: [
//               // AGrappler(),
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20)),
//                   color: appBlue,
//                 ),
//                 child: Column(
//                   children: [
//                     // Pseudo appbar
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Flexible(
//                         //   flex: 0,
//                         //   child: IconButton(
//                         //     icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
//                         //     onPressed: () {
//                         //       // Close page
//                         //       Navigator.of(context).pop();
//                         //     },
//                         //   ),
//                         // ),
//                         Flexible(
//                           child: ListTile(
//                             contentPadding: EdgeInsets.all(0),
//                             leading: CircleAvatar(
//                               backgroundImage: _user.id == ""
//                                   ? null
//                                   : NetworkImage(
//                                       "${_user.profile_picture}",
//                                     ),
//                               child: _user.id == ""
//                                   ? Icon(Icons.person_outline)
//                                   : null,
//                             ),
//                             title: Text(
//                               _date,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             subtitle: _user.id == ""
//                                 ? null
//                                 : Text(
//                                     "${_user.name}",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                           ),
//                         ),
//                         Flexible(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               // Add new event icon
//                               InkWell(
//                                 onTap: () {
//                                   // Open event creation page
//                                   openModalBottomSheet(context,
//                                       view: CreateEventSheet());
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.white.withOpacity(.1),
//                                   ),
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               // Notification icon
//                               Container(
//                                 padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.white.withOpacity(.1),
//                                 ),
//                                 child: Icon(
//                                   Icons.notifications,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               // Close icon
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: Colors.red.withOpacity(.6),
//                                   ),
//                                   child: Icon(
//                                     Icons.close,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     //
//                     // date
//                     ListTile(
//                       contentPadding: EdgeInsets.all(0),
//                       title: Text(
//                         "Tous les évenements de babi à votre portée",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Obx(() {
//                         num count = mapDataController.events.value.length;
//                         String p = count > 1 ? 's' : '';
//                         if (count == 0)
//                           return Text(
//                             "Aucun evenement près de chez vous",
//                             style: TextStyle(color: Colors.white),
//                           );
//                         return Text(
//                           "$count evenement$p près de chez vous",
//                           style: TextStyle(color: Colors.white),
//                         );
//                       }),
//                     ),
//                     // Search bar
//                     Container(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * .8,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: TextField(
//                                 controller: _searchInputController,
//                                 focusNode: _searchFocusNode,
//                                 onChanged: (value) {
//                                   if (value.length > 3) {
//                                     mapDataController.searchPlaces(value);
//                                   }
//                                 },
//                                 // onSubmitted: _searchSubmitted,
//                                 onEditingComplete: () {
//                                   // _searchFocusNode.unfocus();
//                                   // _pageMode = PageMode.Home;
//                                   // setState(() {});
//                                 },
//                                 expands: false,
//                                 decoration: InputDecoration(
//                                   hintText: "Rechercher",
//                                   border: InputBorder.none,
//                                   // focusColor: Colors.grey[100],
//                                   // fillColor: Colors.grey[100],

//                                   prefixIcon: InkWell(
//                                     child: Icon(
//                                       _searchFocusNode.hasFocus
//                                           ? Icons.close
//                                           : Icons.search,
//                                     ),
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: appOrange,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             padding: EdgeInsets.all(10),
//                             child: Icon(
//                               Icons.tune,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     //
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               // Category filter list
//               Container(
//                 height: 50,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 10,
//                 ),
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categories.length,
//                   itemBuilder: (ctx, i) => Center(
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(categories[i]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // No events
//               Container(),

//               // Recommended Events
//               _buildRecommendedEvents(),
//               // Popular Events
//               // _buildPopularEvents(),
//               // events list
//               Expanded(
//                 child: ListView(
//                   children: [],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _buildRecommendedEvents() {
//     return Obx(() {
//       //
//       return mapDataController.events.value.length > 0
//           ? Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Evenements recommendés",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Voir tout",
//                         style: TextStyle(color: appOrange),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 200,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: ListView.separated(
//                     itemCount: mapDataController.events.value.length,
//                     scrollDirection: Axis.horizontal,
//                     separatorBuilder: (ctx, i) => SizedBox(width: 10),
//                     itemBuilder: (ctx, i) => InkWell(
//                       onTap: () {
//                         // Open event detail
//                         print("<< onTap");
//                         openModalBottomSheet(context,
//                             view: EventDetailPage(
//                                 event: mapDataController.events.value[i]));
//                       },
//                       child: AEventCard(
//                         event: mapDataController.events.value[i],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : Container();
//     });
//   }

//   _buildPopularEvents() {
//     return Obx(
//       () => mapDataController.events.value.length > -20
//           ? Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Evenements populaires",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Voir tout",
//                         style: TextStyle(color: appOrange),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 200,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: ListView.separated(
//                       // itemCount: mapDataController.events.value.length,
//                       itemCount: 5,
//                       scrollDirection: Axis.horizontal,
//                       separatorBuilder: (ctx, i) => SizedBox(width: 10),
//                       itemBuilder: (ctx, i) {
//                         IciEvent event = IciEvent(
//                           name: "Event Name",
//                           venue: "JooL International",
//                           cover_url:
//                               "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F142932949%2F526084330373%2F1%2Foriginal.20210728-155130?w=800&auto=format%2Ccompress&q=75&sharp=10&rect=33%2C0%2C3208%2C1604&s=5c7c54badd7045fa1070bab48823ea8b",
//                           // infolines: ["235555"],
//                           email: "email@gmail.com",
//                           start_date: {"date": "25 dec 2103"},
//                           country_code: "ci",
//                           lat: 234,
//                           lon: 3352,
//                         );

//                         return AEventCard(
//                           width: MediaQuery.of(context).size.width * .6,
//                           // event: mapDataController.events.value[i]

//                           event: event,

//                           //
//                           onTap: () {
//                             print(">> onTap EventCard");
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (ctx) =>
//                                     EventDetailPage(event: event)));

//                             // openModalBottomSheet(context,
//                             //     view: EventDetailPage(event: event));
//                           },
//                         );
//                       }),
//                 ),
//               ],
//             )
//           : Container(),
//     );
//   }
// }

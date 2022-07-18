// import 'package:clipboard/clipboard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ici/src/widgets/a_icon.dart';
// import 'package:ici/src/widgets/a_grappler.dart';

// class SettingsSheet extends StatefulWidget {
//   SettingsSheet({Key? key}) : super(key: key);

//   @override
//   _SettingsSheetState createState() => _SettingsSheetState();
// }

// class _SettingsSheetState extends State<SettingsSheet> {
//   String addressCode = "";
//   bool _isLoading = true;
//   bool isEphemere = false;
//   bool isPrivate = false;
//   bool _isCodeLoading = false;

//   _generateCode() async {
//     _isCodeLoading = true;
//     Future.delayed(Duration(seconds: 5));
//     addressCode = "CIAB2145";
//     _isCodeLoading = false;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _isLoading = false;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//       child: DraggableScrollableSheet(
//         // initialChildSize: .4,

//         minChildSize: 1,
//         maxChildSize: 1,
//         initialChildSize: 1,

//         builder: (c, sc) => Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//           ),
//           child: Column(
//             // mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: _isLoading
//                 ? [
//                     AGrappler(),
//                     Spacer(),
//                     CircularProgressIndicator(),
//                     Spacer(),
//                   ]
//                 : [
//                     AGrappler(),

//                     // TitleBox
//                     ListTile(
//                       leading: IconButton(
//                         icon: Icon(
//                           Icons.arrow_back,
//                         ),
//                         onPressed:
//                             // _gotoHomeScreen,
//                             () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       title: Text("Détails de la map"),
//                       subtitle: Text("Choisissez ce que vous voyez"),
//                       trailing: AIcon(
//                         color: Colors.green,
//                         icon: Icons.settings,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.0,
//                     ),
//                     Divider(),
//                     SizedBox(
//                       height: 5.0,
//                     ),
//                     //
//                     // Setting Item
//                     ListTile(
//                       leading: AIcon(
//                         color: Colors.purple,
//                         icon: Icons.beach_access,
//                       ),
//                       title: Text("Zone de détentes"),
//                       subtitle: Text("Afficher les zones de détente"),
//                       trailing: CupertinoSwitch(
//                         value: true,
//                         onChanged: (_) {},
//                         // _settingChanged,
//                       ),
//                     ),
//                   ],
//           ),
//         ),
//       ),
//     );
//   }
// }

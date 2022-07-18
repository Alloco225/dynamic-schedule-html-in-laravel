// import 'package:clipboard/clipboard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ici/src/controllers/AuthDataController__.dart';
// import 'package:ici/src/controllers/MapDataController.dart';
// import 'package:ici/src/models/http_exception.dart';
// import 'package:ici/src/screens/auth_screen.dart';
// import 'package:ici/src/services/remote/api/auth_api.dart';
// import 'package:ici/src/widgets/a_grappler.dart';
// import 'package:ici/src/widgets/make_dismissable.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// enum AuthMode { Login, Register }

// class AuthenticationSheet extends StatefulWidget {
//   final AuthMode? initAuthMode;

//   AuthenticationSheet({this.initAuthMode});

//   @override
//   _AuthenticationSheetState createState() => _AuthenticationSheetState();
// }

// class _AuthenticationSheetState extends State<AuthenticationSheet>
//     with SingleTickerProviderStateMixin {
//   //
//   // late AuthMode _authMode;

//   final GlobalKey<FormState> _formKey = GlobalKey();
//   late AuthMode _authMode;

//   late final MapDataController mapDataController;
//   // late final AuthDataController authDataController;

//   Map<String, String> _authData = {
//     'phone': '',
//     'password': '',
//   };
//   var _isLoading = false;
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _opacityAnimation;

//   late final _passwordController;
//   //
//   late final _nameFocusNode;
//   late final _phoneFocusNode;
//   late final _passwordFocusNode;
//   late final _passwordConfirmFocusNode;

//   late final _authService;

//   Map textData = {
//     AuthMode.Login: {
//       'title': "Connexion à Ici",
//       'subtitle': "Bon retour parmi nous",
//       'with_phone': "Se connecter avec Numéro de téléphone ",
//       'notice': "Vous n'avez pas de compte ?",
//       'notice_btn': "INSCRIPTION",
//     },
//     AuthMode.Register: {
//       'title': "Inscription à Ici",
//       'subtitle': "Rejoignez la communauté ICI",
//       'with_phone': "S'inscire avec Numéro de téléphone ",
//       'notice': "Vous avez déjà un compte ?",
//       'notice_btn': "CONNEXION",
//     },
//   };

//   @override
//   void initState() {
//     super.initState();

//     print("<<** Auth sheet");
//     mapDataController = Get.find();
//     // authDataController = Get.find();
//     //
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(
//         milliseconds: 300,
//       ),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, -1.5),
//       end: Offset(0, 0),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.fastOutSlowIn,
//       ),
//     );
//     _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeIn,
//       ),
//     );
//     // _heightAnimation.addListener(() => setState(() {}));

//     _passwordController = TextEditingController();
//     _nameFocusNode = FocusNode();
//     _phoneFocusNode = FocusNode();
//     _passwordFocusNode = FocusNode();
//     _passwordConfirmFocusNode = FocusNode();

//     _authService = AuthService();

//     //

//     _authMode = widget.initAuthMode ?? AuthMode.Register;

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     _passwordController.dispose();
//     _nameFocusNode.dispose();
//     _phoneFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     _passwordConfirmFocusNode.dispose();
//     super.dispose();
//   }

//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Register;
//       });
//       _controller.forward();
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//       _controller.reverse();
//     }
//   }

//   //Auth form submission

//   Future<void> _submit() async {
//     print(">>> _submit()");
//     if (!_formKey.currentState!.validate()) {
//       print("form invalid");
//       // Invalid!
//       return;
//     }

//     //
//     _formKey.currentState?.save();
//     if (_authMode == AuthMode.Login)
//       _passwordFocusNode.unfocus();
//     else
//       _passwordConfirmFocusNode.unfocus();

//     setState(() {
//       _isLoading = true;
//     });
//     //
//     try {
//       if (_authMode == AuthMode.Login) {
//         await mapDataController.verifyPassword(
//             _authData['phone'] as String, _authData['password'] as String);
//       } else {
//         // Sign user up
//         // TODO
//         await mapDataController.signupNewUser(_authData);
//       }

//       // pop and set user
//       // await Future.delayed(Duration(seconds: ));
//       //
//       //
//       print("<<< authTerminated");
//       print(mapDataController.user.value.id);
//       //
//       if (mapDataController.user.value.id != "") {
//         showTopSnackBar(
//           context,
//           CustomSnackBar.success(
//             message: "Bienvenue ${mapDataController.user.value.name}",
//           ),
//         );
//         Navigator.of(context).pop();
//       }
//       //
//     } on HttpException catch (error) {
//       print("<< HttpException");
//       var errorMessage = 'Authentication failed';
//       //
//       if (error.toString().contains('PHONE_EXISTS')) {
//         errorMessage = "Numéro de téléphone déjà utilisé";
//       } else if (error.toString().contains('INVALID_PHONE')) {
//         errorMessage = "Ce numéro de téléphone n'est pas valide";
//       } else if (error.toString().contains('WEAK_PASSWORD')) {
//         errorMessage = "Ce mot de passe est trop faible";
//       } else if (error.toString().contains('PHONE_NOT_FOUND')) {
//         errorMessage = "Aucun utilisateur avec ce numéro de téléphone";
//       } else if (error.toString().contains('INVALID_PASSWORD')) {
//         errorMessage = "Mot de passe invalide";
//       }
//       // _showErrorDialog(errorMessage);
//       showTopSnackBar(
//         context,
//         CustomSnackBar.error(
//           message: errorMessage,
//         ),
//       );
//     } catch (error) {
//       print("<< Error");

//       showTopSnackBar(
//         context,
//         CustomSnackBar.error(
//           message:
//               "Nous n'avons pas pu vous identifier. Veuillez réessayer plus tard",
//         ),
//       );
//       // const errorMessage =
//       //     'Could not authenticate you. Please try again later.';
//       // _showErrorDialog(errorMessage);
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;

//     return makeDismissible(
//       context: context,
//       shouldDismiss: _isLoading,
//       child: DraggableScrollableSheet(
//         // initialChildSize: 0.9,
//         initialChildSize: 1,

//         builder: (_, controller) {
//           // controller.
//           // TODO : disable scroll when _isLoading
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//             ),
//             child: Column(
//               children: [
//                 AGrappler(),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // title
//                     Text(
//                       textData[_authMode]["title"],
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child:
//                       // subtitle
//                       Text(
//                     textData[_authMode]["subtitle"],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.grey[700],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Divider(
//                   height: 20,
//                 ),
//                 Spacer(flex: 1),
//                 Expanded(
//                   // flex: deviceSize.width > 600 ? 4 : 2,
//                   flex: 5,
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 300),

//                     curve: Curves.easeIn,
//                     height: _authMode == AuthMode.Register ? 320 : 260,
//                     // height: _heightAnimation.value.height,
//                     constraints: BoxConstraints(
//                         minHeight: _authMode == AuthMode.Register ? 320 : 260),

//                     padding: EdgeInsets.all(16.0),
//                     child: Form(
//                       key: _formKey,
//                       // autovalidateMode: AutovalidateMode.,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: <Widget>[
//                             // Name input
//                             AnimatedContainer(
//                               constraints: BoxConstraints(
//                                 minHeight:
//                                     _authMode == AuthMode.Register ? 60 : 0,
//                                 maxHeight:
//                                     _authMode == AuthMode.Register ? 120 : 0,
//                               ),
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeIn,
//                               child: FadeTransition(
//                                 opacity: _opacityAnimation,
//                                 child: SlideTransition(
//                                   position: _slideAnimation,
//                                   child: TextFormField(
//                                     focusNode: _nameFocusNode,
//                                     enabled: _authMode == AuthMode.Register,
//                                     decoration: InputDecoration(
//                                         labelText: "Nom et prénoms",
                                        
//                                         ),
//                                         textInputAction: TextInputAction.done,
//                                     validator: _authMode == AuthMode.Register
//                                         ? (value) {
//                                             if (value!.length == 0) {
//                                               return "Vous avez oublié votre nom";
//                                             }
//                                             if (value.length < 3) {
//                                               return "Au moins 3 charactères !";
//                                             }
//                                           }
//                                         : null,
//                                     onSaved: (value) {
//                                       _authData['name'] = value ?? "";
//                                       //
//                                     },
//                                     onEditingComplete: () {
//                                       _phoneFocusNode.requestFocus();
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             TextFormField(
//                               focusNode: _phoneFocusNode,
//                               decoration: InputDecoration(
//                                   labelText: "Numéro de téléphone"),
//                               keyboardType: TextInputType.phone,
//                               validator: (value) {
//                                 if (value!.isEmpty || value.length < 10) {
//                                   return "Téléphone invalide !";
//                                 }
//                               },
//                               onSaved: (value) {
//                                 _authData['phone'] = value ?? "";
//                                 //
//                               },
//                               onEditingComplete: () {
//                                 _passwordFocusNode.requestFocus();
//                               },
//                             ),
//                             TextFormField(
//                               decoration:
//                                   InputDecoration(labelText: "Mot de passe"),
//                               obscureText: true,
//                               controller: _passwordController,
//                               focusNode: _passwordFocusNode,
//                               validator: (value) {
//                                 if (value!.isEmpty || value.length < 5) {
//                                   return "Mot de passe trop court!";
//                                 }
//                               },
//                               onSaved: (value) {
//                                 _authData['password'] = value ?? "";
//                               },
//                               onEditingComplete: () {
//                                 //
//                                 if (_authMode == AuthMode.Register) {
//                                   _passwordConfirmFocusNode.requestFocus();
//                                   return;
//                                 }
//                                 //
//                                 _submit();
//                               },
//                             ),
//                             AnimatedContainer(
//                               constraints: BoxConstraints(
//                                 minHeight:
//                                     _authMode == AuthMode.Register ? 60 : 0,
//                                 maxHeight:
//                                     _authMode == AuthMode.Register ? 120 : 0,
//                               ),
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeIn,
//                               child: FadeTransition(
//                                 opacity: _opacityAnimation,
//                                 child: SlideTransition(
//                                   position: _slideAnimation,
//                                   child: TextFormField(
//                                     focusNode: _passwordConfirmFocusNode,
//                                     enabled: _authMode == AuthMode.Register,
//                                     decoration: InputDecoration(
//                                         labelText: 'Confirmez mot de passe'),
//                                     obscureText: true,
//                                     validator: _authMode == AuthMode.Register
//                                         ? (value) {
//                                             if (value !=
//                                                 _passwordController.text) {
//                                               return "Les mots de passe sont différents!";
//                                             }
//                                           }
//                                         : null,
//                                     onEditingComplete: _submit,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             if (_isLoading)
//                               CircularProgressIndicator()
//                             else
//                               RaisedButton(
//                                 child: Text(_authMode == AuthMode.Login
//                                     ? 'SE CONNECTER'
//                                     : "S'INSCRIRE"),
//                                 onPressed: _submit,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 30.0, vertical: 8.0),
//                                 color: Theme.of(context).primaryColor,
//                                 textColor: Theme.of(context)
//                                     .primaryTextTheme
//                                     .button
//                                     ?.color,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 Spacer(),
//                 // Conditions

//                 Container(
//                   color: Colors.grey[100],
//                   padding: EdgeInsets.all(20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         textData[_authMode]["notice"],
//                         style: TextStyle(
//                           // color: Colors.red,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: _isLoading ? null : _switchAuthMode,
//                         child: Text(
//                           textData[_authMode]["notice_btn"],
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class LoginMethod extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback? callback;

//   const LoginMethod(
//     this.text, {
//     required this.icon,
//     this.callback,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: callback,
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 5,
//         ),
//         padding: EdgeInsets.only(left: 10),
//         decoration: BoxDecoration(
//             color: callback != null ? Colors.white : Colors.grey[300],
//             border: Border.all(
//               width: 1,
//               color: Colors.grey,
//             ),
//             borderRadius: BorderRadius.circular(10)),
//         child: ListTile(
//           contentPadding: EdgeInsets.all(0),
//           leading: Icon(
//             icon,
//           ),
//           title: Text(
//             "$text",
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

class Styles {
  static final theme = ThemeData(
    fontFamily: 'CeraPro',
  );

  /// ? Text
  /// ? For onboarding titles
  static const h1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  static const h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
  static const h3 = TextStyle(fontWeight: FontWeight.bold, fontSize: 23);
  static const h4 = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  static const h5 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const h6 = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  
  static const small =
      TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey);
  //
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const subtitle = TextStyle(fontWeight: FontWeight.w500);
  //
  static final subtitle_error = subtitle.copyWith(color: Colors.red);
  static final subtitle_success = subtitle.copyWith(color: Colors.green);

  /// ? For buttons
  static const button_white =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

  /// ? Animations
  ///
  static const animationDuration = Duration(milliseconds: 300);
  static const animationCurve = Curves.easeOut;
}

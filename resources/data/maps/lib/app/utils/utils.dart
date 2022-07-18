import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class Utils {
  static log(dynamic s) => debugPrint("\n\n***=== $s ===***\n\n");

  static launchUrl(url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  /// ?
  /// ? Math n random ness

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static const _nums = '1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  static String getRandomNumbersString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _nums.codeUnitAt(_rnd.nextInt(_nums.length))));
}

class UIUtils {
  /// ? UI Widgets n stuff
  static Future<dynamic> openModalBottomSheet(BuildContext context,
      {required Widget view}) {
    debugPrint("<<< openModalBottomSheet");
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => view,
    );
  }

  static Widget makeDismissible({
    required Widget child,
    context,
    bool shouldDismiss = true,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: shouldDismiss ? () => Navigator.of(context).pop() : null,
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}

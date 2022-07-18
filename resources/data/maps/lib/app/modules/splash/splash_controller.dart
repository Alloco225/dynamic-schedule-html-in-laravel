// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SplashController extends GetxController {

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }



//   // Checks if user has onboarded yet
//   Future<bool> checkOnboarding() async {
//     debugPrint(">> checkOnboarding");
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('ICI_COLLECTOR_ONBOARDING')) {
//       debugPrint("\n\n\n<<<< Onboarding false :nokey");
//       return false;
//     }
//     var onboarding = prefs.getBool('ICI_COLLECTOR_ONBOARDING');
//     if (onboarding == null && onboarding == false) {
//       debugPrint("\n\n\n<<<< Onboarding false || null");
//       return false;
//     }
//     return true;
//   }
// }

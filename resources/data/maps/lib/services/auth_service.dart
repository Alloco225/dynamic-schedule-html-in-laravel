import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// class AuthService extends GetxService {
class AuthService extends GetxController {
  static AuthService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    debugPrint("\n\n** AuthService says hello **\n");
  }

  /// Mocks a login process
  final isLoggedIn = false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
}

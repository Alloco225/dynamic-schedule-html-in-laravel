import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// class StorageService extends GetxService {
class StorageService extends GetxController {
  static StorageService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    debugPrint("\n\n** StorageService is up **\n");
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

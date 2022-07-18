import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//
import '/app/const/env.dart';

class ApiService extends GetxService {
// class ApiService extends GetxController {
  static ApiService get to => Get.find();
  //

  @override
  void onInit() {
    super.onInit();
    debugPrint("\n\n** ApiService connected **\n");
    debugPrint("\n>>> ApiCheck **\n");
    debugPrint("\n<< Internet status: online **\n");
    debugPrint("\nxx Internet status: offline **\n");
    debugPrint("\n<< API status: up and running **\n");
    debugPrint("\nxx API status: unreachable **\n");
  }

  /// Mocks a login process
  final isLoggedIn = false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  Future login(Map payload) async {
    var url = Uri.parse(ENV.API_URL + "/login");
    debugPrint("\n>> login $url $payload");
    var response = await http.post(url);
    var data = response.body;
    debugPrint("\n<< login $data");
    return data;
  }
  /// ?
  /// 
  Future verifyOtp(Map payload) async {
    var url = Uri.parse(ENV.API_URL + "/verifyOtp");
    debugPrint("\n>> verifyOtp $url $payload");
    var response = await http.post(url);
    var data = response.body;
    debugPrint("\n<< verifyOtp $data");
    return data;
  }
  /// ?
  /// 
  Future resendOtp(Map payload) async {
    var url = Uri.parse(ENV.API_URL + "/resendOtp");
    debugPrint("\n>> resendOtp $url $payload");
    var response = await http.post(url);
    var data = response.body;
    debugPrint("\n<< resendOtp $data");
    return data;
  }

  /// ?
  void logout() {
    isLoggedIn.value = false;
  }
}

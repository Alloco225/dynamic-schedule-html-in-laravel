import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ici/app/utils/utils.dart';
import 'package:ici/services/api_service.dart';

import 'auth_form_controller.dart';

class AuthController extends GetxController {
  /// ? Initialisation
  final AuthFormController _authFormController = Get.find();
  final ApiService _apiService = Get.find();

  @override
  void onInit() {
    super.onInit();
    debugPrint("\n\n\n** AuthController says bonjour **\n\n");
  }

  Future<bool> login() async {
    debugPrint("\n**> Login");

    Map loginPayLoad = _authFormController.registerCredentials;

    /// ? Add device Info
    ///
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final deviceInfoData = deviceInfo.toMap();

    /// ? Login payload with *userCredentials and *deviceInfo
    // loginPayLoad.addAll(deviceInfoData);
    loginPayLoad['device'] = deviceInfoData;

    var response = await _apiService.login(loginPayLoad);

    /// ? Manage OTP too
    _authFormController.serverOtp = "12458";
    int min = 4;
    int max = 6;
    var val = min + Random().nextInt(max - min);
    _authFormController.serverOtp = Utils.getRandomNumbersString(val);
    _authFormController.otpController.text = "";

    debugPrint("\n**< Login $response ");
    debugPrint("\n< otp : ${_authFormController.serverOtp} ");
    return true;
  }

  Future<bool> verifyOtp() async {
    debugPrint("\n**> verifyOtp");

    Map otpPayload = _authFormController.registerCredentials;
    otpPayload['otp'] = _authFormController.otpController.text;


    var response = await _apiService.verifyOtp(otpPayload);
    _authFormController.otpController.text = "";

    /// ? Go to home page
    return true;
  }

  Future resendOtp() async {
    debugPrint("\n**> resendOtp");

    Map loginPayLoad = _authFormController.registerCredentials;
    var response = await _apiService.resendOtp(loginPayLoad);

    /// ? Manage OTP too
    _authFormController.serverOtp = "12458";
    int min = 4;
    int max = 6;
    var val = min + Random().nextInt(max - min);
    _authFormController.serverOtp = Utils.getRandomNumbersString(val);
    _authFormController.otpController.text = "";
    debugPrint("\n**< resendOtp $response ");
    debugPrint("\n< otp : ${_authFormController.serverOtp} ");
    return true;
  }
}

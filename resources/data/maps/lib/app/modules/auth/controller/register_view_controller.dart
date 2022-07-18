// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ici/app/modules/auth/controller/auth_controller.dart';
import 'package:ici/app/modules/auth/controller/auth_form_controller.dart';

class RegisterViewController extends GetxController {
  final AuthFormController _authFormController = Get.find();
  final AuthController _authController = Get.find();
  double heightFactor = .6;

  final _pageState = PageState.Register.obs;
  get pageState => _pageState.value;
  final _modalState = OverlayModalState.None.obs;
  get modalState => _modalState.value;

  ///
  ///
  setModal(
    OverlayModalState state, {
    int? duration,
    int delay = 0,
  }) async {
    //
    await Future.delayed(Duration(milliseconds: delay));
    _modalState.value = state;
    //
    if (duration != null) {
      await Future.delayed(Duration(milliseconds: duration));
      _modalState.value = OverlayModalState.None;
    }
  }

  clearModal() {
    setModal(OverlayModalState.None);
  }

  setPage(PageState state) {
    _pageState.value = state;
  }

  resetPage() {
    // clear input controllers
    // return to original page
    _pageState.value = PageState.Register;
  }

  exitPage() {}

  /// ? Main button action text
  ///
  get mainButtonActionText {
    String text = "Continuer";

    if (modalState == OverlayModalState.Loading) {
      text = "Patientez";
    }
    if (modalState == OverlayModalState.Error) {
      text = "Réessayer";
    }
    if (pageState == PageState.VerifyPhone) {
      text = "Vérifier";
    }
    return text.toUpperCase();
  }

  get isMainButtonActive {
    if (modalState == OverlayModalState.Loading) return false;
    if (pageState == PageState.Register) {
      return _authFormController.isFormValid();
    }
    if (pageState == PageState.VerifyPhone) {
      return _authFormController.isOtpValid;
    }

    /// ? shorter version
    // return (pageState == PageState.Register &&
    //         _authFormController.isFormValid()) ||
    //     (pageState == PageState.VerifyPhone && _authFormController.isOtpValid);

    return false;
  }

  validateOtp(_) async {
    //
    await _authFormController.validateOtp(_);
    if (!_authFormController.isOtpValid) return;
    //
    setModal(OverlayModalState.Loading);
    try {
      debugPrint("oo< validateOtp $_");
      await _authController.verifyOtp();
      setModal(OverlayModalState.Success, duration: 1000);
    } catch (e) {
      debugPrint("\noox $e");
      setModal(OverlayModalState.Error);
    }
  }

  resendOtp() async {
    debugPrint("\noo> resendOtp");

    /// ? Clear input
    _authFormController.otpController.text = "";
    if (modalState == OverlayModalState.Loading) return;
    setModal(OverlayModalState.Loading);
    try {
      await _authController.resendOtp();
      debugPrint("oo< resendOtp");

      setModal(OverlayModalState.Success, duration: 1000);
    } catch (e) {
      debugPrint("\noox $e");
      setModal(OverlayModalState.Error);
    }
  }
}

enum PageState { Register, Loading, VerifyPhone }
enum OverlayModalState { None, Loading, Error, Success }

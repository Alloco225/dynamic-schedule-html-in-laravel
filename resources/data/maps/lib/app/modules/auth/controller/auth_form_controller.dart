import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ici/app/modules/auth/controller/auth_controller.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:phone_number/phone_number.dart' as iso;

class AuthFormController extends GetxController {
  // final AuthController _authController = Get.find();

  /// ? Initialisation
  /// ? Register Form stuff
  ///
  /// Data
  ///
  final _otp = "".obs;
  get otp => _otp.value;

  final _serverOtp = "".obs;
  get serverOtp => _serverOtp.value;

  set serverOtp(v) => _serverOtp.value = v;

  /// Controllers
  // late TextEditingController _nameController;
  // late TextEditingController _phoneController;
  final _nameController = TextEditingController().obs;
  final _phoneController = TextEditingController().obs;
  final _otpController = TextEditingController().obs;

  /// ? Phone verification
  get nameController => _nameController.value;
  get phoneController => _phoneController.value;
  get otpController => _phoneController.value;

  /// FocusNodes
  final _nameFocusNode = FocusNode().obs;
  final _phoneFocusNode = FocusNode().obs;
  final _otpFocusNode = FocusNode().obs;

  /// ?

  get nameFocusNode => _nameFocusNode.value;
  get phoneFocusNode => _phoneFocusNode.value;
  get otpFocusNode => _otpFocusNode.value;

  /// User credentials
  ///
  get registerCredentials => {
        "name": nameController.text,
        "phone": number.phoneNumber,
        "country": number.isoCode,
      };

  /// Error messages

  final _nameError = "".obs;
  final _phoneError = "".obs;
  final _termsError = "".obs;

  /// Verify Phone
  final _otpError = "".obs;

  get nameError => _nameError.value;
  get phoneError => _phoneError.value;
  get termsError => _termsError.value;
  get otpError => _otpError.value;

  // User Agreement
  final _termsAccepted = false.obs;
  get termsAccepted => _termsAccepted.value;

  /// ? International phone input
  ///
  ///
  iso.PhoneNumberUtil phoneUtil = iso.PhoneNumberUtil();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String initialCountry = 'CI';
  final _number = PhoneNumber(isoCode: 'CI').obs;
  get number => _number.value;

  /// ? Inits

  @override
  void onInit() {
    super.onInit();
    debugPrint("\n\n\n** AuthFormController dans la place **\n\n");
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    otpController.dispose();
    //
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
  }

  /// *** VERIFY PHONE FUNCTIONS
  ///

  validateOtp(value) {
    _otpError.value = "";
    bool isValid = value == serverOtp;
    if (!isValid) {
      _otpError.value = "Code invalide";
      return;
    }
  }

  get isOtpValid =>
      otpController.text.length == serverOtp.length && otpError == "";

  ///
  ///
  /// *** REGISTER FUNCTIONS

  /// onNameChanged
  /// ? On name changed
  onNameChanged(String value) {
    // ! Active validation
    _nameError.value = "";
    if (value == "") {
      _nameError.value = "Vous avez oublié votre nom";
      return;
    }
    if (value.length < 3) {
      _nameError.value = "Nom trop court";
      return;
    }
  }

  onNameEditingComplete() {
    // if (_nameError == null) {
    //   _nameFocusNode.requestFocus();
    //   return;
    // }
    // ! // TODO validate
    phoneFocusNode.requestFocus();
  }

  onNameSubmitted(String value) {
    // if (_nameError == null) {
    //   _nameFocusNode.requestFocus();
    //   return;
    // }
    phoneFocusNode.requestFocus();

    // if(_phoneError == null){
    // }
    //   _phoneFocusNode.requestFocus();
  }

  /// ? Name validation
  ///

  /// ? Phone validation
  ///

  _validatePhone() async {
    debugPrint("\n\n>> _validatePhone ${number.phoneNumber} ${number.isoCode}");
    try {
      _phoneError.value = "";
      if (number.phoneNumber == null) {
        _phoneError.value = "Vous avez oublié votre numéro";
        return false;
      }
      // iso.PhoneNumber phoneNumber = await iso.PhoneNumberUtil().parse(value);
      bool isValid =
          await phoneUtil.validate(number.phoneNumber!, number.isoCode!);
      debugPrint("\n\n<< $isValid");
      if (!isValid) {
        _phoneError.value = "N° de téléphone invalide";
      }
      return isValid;
    } catch (e) {
      debugPrint("\n\nxx $e");
      return false;
    }
  }

  onPhoneChanged(PhoneNumber number) {
    debugPrint(">> onPhoneChanged $number");
    debugPrint(number.phoneNumber);
    debugPrint(number.isoCode);
    _number.value = number;

    if (_phoneError != null) {
      _validatePhone();
    }
  }

  onPhoneSubmitted(String _) async {
    debugPrint(
        "\n\n>> onPhoneSubmitted $_ ${number.phoneNumber} ${number.isoCode}");

    if (!await _validatePhone()) return;
    // _mainButtonAction();
  }

  isFormValid() =>
      _nameError.value == "" && _phoneError.value == "" && _termsAccepted.value;

  /// ? Terms
  toggleTerms() {
    _termsAccepted.value = !_termsAccepted.value;
    if (_termsAccepted.value) _termsError.value = "";
  }

  /// ? Opens terms and conditions webpage
  ///
  _openTerms() async {
    debugPrint(">> openTerms ");
  }

  /// ? Form stuff
  ///
  validateForm() async {
    onNameChanged(_nameController.value.text);
    await _validatePhone();
    // FocusScope.of(context).unfocus();

    return nameError == "" && phoneError == "";
    // return _isFormValid();
  }

  validateTerms() {
    _termsError.value = "";
    // setState(() {});
    if (!_termsAccepted.value) {
      _termsError.value = "Faut lire et accepter les termes d'utilisation stp";
      // setState(() {});
      return;
    }
  }
}

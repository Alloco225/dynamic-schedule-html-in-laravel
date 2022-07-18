import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ici/app/modules/auth/controller/auth_controller.dart';
import 'package:ici/app/modules/auth/controller/register_view_controller.dart';
import 'package:ici/app/modules/auth/controller/timer_controller.dart';
import '/app/const/styles.dart';
import '/app/modules/auth/controller/auth_form_controller.dart';
import '/app/widgets/forms.dart';
import 'pin_input_view.dart';

class VerifyPhoneForm extends StatelessWidget {
  VerifyPhoneForm({Key? key}) : super(key: key);

  final RegisterViewController _registerViewController = Get.find();
  final AuthFormController _authFormController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(FeatherIcons.lock, size: 40),
          const SizedBox(height: 10),
          Text(
            "Entre le code PIN",
            style: Styles.h2.copyWith(color: Colors.blueGrey.shade700),
          ),
          const SizedBox(height: 10),

          const Text(
            "Nous avons envoyé un code sur le ",
            textAlign: TextAlign.center,
            style: Styles.small,
          ),
          InkWell(
            onTap: _registerViewController.resetPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _authFormController.registerCredentials['phone'],
                  textAlign: TextAlign.center,
                  style: Styles.title.copyWith(color: Colors.blueGrey),
                ),
                const SizedBox(width: 5),
                Text(
                  "Modifier",
                  style: Styles.subtitle.copyWith(color: Colors.blueGrey),
                ),
                const SizedBox(width: 2),
                const Icon(FeatherIcons.edit2,
                    size: 13, color: Colors.blueGrey),
              ],
            ),
          ),

          /// ? OTP Code Input Form
          ///
          ///
          const Spacer(),
          Obx(
            () => PinInputView(
              controller: _authFormController.otpController,
              focusNode: _authFormController.otpFocusNode,
              length: _authFormController.serverOtp.length,
              onCompleted: _registerViewController.validateOtp,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              opacity: _authFormController.otpError == "" ? 0 : 1,
              child: ValidatedInputLabel(
                text: "",
                error: _authFormController.otpError,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
          ResendTimerView(onResend: _registerViewController.resendOtp),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class ResendTimerView extends StatefulWidget {
  final VoidCallback? onResend;
  const ResendTimerView({
    Key? key,
    this.onResend,
  }) : super(key: key);

  @override
  State<ResendTimerView> createState() => _ResendTimerViewState();
}

class _ResendTimerViewState extends State<ResendTimerView> {
  late Timer _timer;

  late int endTime;
  int waitTime = 30;
  int duration = 30;
  int tries = 1;
  bool isLoading = false;
  bool canResendCode = false;

  String? code;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    canResendCode = false;
    duration = waitTime * tries;
    debugPrint("** Timer for ${duration}s **");
    setState(() {});
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (duration == 0) {
          setState(() {
            tries++;
            canResendCode = true;
            timer.cancel();
          });
        } else {
          setState(() {
            duration--;
          });
        }
      },
    );
  }

  resend() {
    startTimer();
    if (widget.onResend != null) {
      widget.onResend!();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _timerText() {
    if (duration == 0) return '';
    var min = (duration / 60).floor();
    var sec = duration % 60;

    return "${min >= 10 ? min : '$min'}:${sec >= 10 ? sec : '0$sec'}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _timerText(),
          style: Styles.subtitle,
        ),
        TextButton(
          onPressed: canResendCode ? resend : null,
          child: Text(
            "Renvoyer le code".toUpperCase(),
            style: Styles.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: canResendCode
                  ? Colors.blueGrey.shade600
                  : Colors.blueGrey.shade200,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

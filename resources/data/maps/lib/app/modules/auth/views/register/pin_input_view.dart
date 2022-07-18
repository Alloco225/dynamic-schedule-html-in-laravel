import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ici/app/modules/auth/controller/auth_form_controller.dart';
import 'package:pinput/pinput.dart';

class PinInputView extends StatelessWidget {
  final int length;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String _)? onChanged;
  final Function(String _)? onCompleted;

  const PinInputView({
    Key? key,
    required this.length,
    required this.controller,
    required this.onCompleted,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);
  //

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: onCompleted,
        onChanged: onChanged,
        
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

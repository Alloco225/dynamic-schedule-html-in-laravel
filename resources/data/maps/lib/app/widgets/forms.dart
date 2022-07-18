import 'package:flutter/material.dart';

class InputLabelView extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? textColor;
  final Color? iconColor;
  final MainAxisAlignment? mainAxisAlignment;

  const InputLabelView({
    Key? key,
    required this.text,
    this.icon,
    this.textColor,
    this.iconColor,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          Icon(
            icon ?? Icons.check_circle,
            size: 17,
            color: iconColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class InputFormView extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;

  final Widget? trailing;
  final TextStyle? textStyle;

  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  //
  const InputFormView({
    Key? key,
    this.hintText,
    this.textEditingController,
    this.focusNode,
    this.trailing,
    this.textStyle,
    this.keyboardType,
    this.onEditingComplete,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: TextField(
          controller: textEditingController,
          focusNode: focusNode,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          style: textStyle,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
        ),
        trailing: trailing,
        onTap: () {},
      ),
    );
  }
}

///
///
/// ? Displays normal label
/// ? Switches label when error != null
///

class ValidatedInputLabel extends StatelessWidget {
  final String? text;
  final String error;
  final MainAxisAlignment? mainAxisAlignment;

  const ValidatedInputLabel({
    Key? key,
    required this.text,
    required this.error,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error.isNotEmpty) {
      return InputLabelView(
        text: error,
        textColor: Colors.red,
        icon: Icons.error_rounded,
        iconColor: Colors.red,
        mainAxisAlignment: mainAxisAlignment,
      );
    }
    if (text == null) {
      return Container();
    }
    return InputLabelView(
      text: text!,
    );
  }
}

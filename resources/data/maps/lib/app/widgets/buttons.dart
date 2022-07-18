import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ActionButton extends StatelessWidget {
  final int flex;
  final Widget? child;
  final List<Widget>? children;
  final VoidCallback action;
  final BorderSide borderSide;
  final Color? fillColor;
  final String? heroTag;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  final EdgeInsets? padding;

  const ActionButton({
    Key? key,
    required this.action,
    this.borderSide = BorderSide.none,
    this.fillColor,
    this.child,
    this.children,
    this.padding,
    this.flex = 0,
    this.heroTag,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: RawMaterialButton(
        onPressed: action,
        fillColor: fillColor,
        elevation: 0,
        padding: padding ?? const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          side: borderSide,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ??
            Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.end,
              children: children!,
            ),
      ),
    );
    return Expanded(
      flex: flex,
      child: heroTag == null
          ? content
          : Hero(
              tag: heroTag!,
              child: content,
            ),
    );
  }
}

class BackArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BackArrowButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      action: onPressed,
      heroTag: "backArrowButton",
      fillColor: Colors.white,
      borderSide: BorderSide(color: Colors.grey.shade300),
      child: const Icon(FeatherIcons.arrowLeft, size: 20,),
    );
  }
}

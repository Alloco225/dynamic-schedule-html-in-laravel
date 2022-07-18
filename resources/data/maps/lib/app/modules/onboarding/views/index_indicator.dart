import 'package:flutter/material.dart';

class SlidingIndexIndicatorView extends StatelessWidget {
  final int count;
  final int activeIndex;
  const SlidingIndexIndicatorView({
    Key? key,
    this.count = 3,
    this.activeIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: i == activeIndex ? 20 : 5,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(100)),
          ),
          if (i != count - 1) const SizedBox(width: 5),
        ]
      ],
    );
  }
}

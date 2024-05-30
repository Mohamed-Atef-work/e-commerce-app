import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AnimationHelperWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final Widget? child;

  const AnimationHelperWidget({
    super.key,
    this.child,
    required this.width,
    required this.height,
    this.color = kWhiteGray,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

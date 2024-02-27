import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AnimationHelperWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const AnimationHelperWidget({
    super.key,
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
    );
  }
}

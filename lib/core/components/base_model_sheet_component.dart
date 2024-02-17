import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class BaseModelSheetComponent extends StatelessWidget {
  final double height;
  final Widget child;
  const BaseModelSheetComponent({
    super.key,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColorYellow,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        border: Border.all(color: kWhite, style: BorderStyle.solid),
      ),
      child: child,
    );
  }
}

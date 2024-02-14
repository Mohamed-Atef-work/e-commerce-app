import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20,
      thickness: 0.5,
      color: Colors.black,
      indent: context.width * 0.05,
      endIndent: context.width * 0.05,
    );
  }
}

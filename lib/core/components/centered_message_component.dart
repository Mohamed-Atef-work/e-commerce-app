import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CenteredMessageComponent extends StatelessWidget {
  final String message;
  const CenteredMessageComponent(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        fontSize: 25,
        text: message,
        fontFamily: kPacifico,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

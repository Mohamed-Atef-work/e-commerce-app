import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class MessengerComponent extends StatelessWidget {
  final String mess;
  const MessengerComponent(this.mess, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: mess,
        fontSize: 25,
        fontFamily: kPacifico,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/images.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class MessengerComponent extends StatelessWidget {
  final String mess;
  final double? imageWidth;
  final double? imageHeight;
  const MessengerComponent(
    this.mess, {
    this.imageWidth,
    this.imageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.message,
            width: imageWidth ?? context.width * 0.4,
            height: imageHeight ?? context.height * 0.3,
          ),
          SizedBox(height: context.height * 0.01),
          CustomText(
            text: mess,
            fontSize: 25,
            fontFamily: kPacifico,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import 'custom_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Images.logoIcon,
            fit: BoxFit.contain,
            width: context.width * 0.3,
            height: context.width * 0.3,
          ),
          const Positioned(
            bottom: 0,
            child: CustomText(
              fontSize: 20,
              fontFamily: kPacifico,
              text: AppStrings.buyIt,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

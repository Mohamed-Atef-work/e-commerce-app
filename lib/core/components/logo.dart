import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_strings.dart';
import 'custom_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: Column(
        children: [
          SvgPicture.asset(
            Images.logoIcon,
            fit: BoxFit.contain,
            width: context.width * 0.15,
            height: context.width * 0.15,
          ),
          const CustomText(
            fontSize: 20,
            fontFamily: kPacifico,
            text: AppStrings.buyIt,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

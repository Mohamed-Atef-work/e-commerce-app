import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import 'custom_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/icons/login_buy_icon.png",
            fit: BoxFit.contain,
            width: width * 0.3,
            height: width * 0.3,
          ),
          const Positioned(
            bottom: 0,
            child: CustomText(
              text: AppStrings.buyIt,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "Pacifico",
            ),
          ),
        ],
      ),
    );
  }
}

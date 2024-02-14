import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';

class AdminPanelScreen extends StatelessWidget {
  AdminPanelScreen({
    super.key,
  });

  final List<String> _buttonNames = [
    AppStrings.add,
    AppStrings.edit,
    AppStrings.viewOrders,
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColorYellow,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _buttonNames.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                child: CustomButton(
                  //fontSize: 20,
                  width: width * 0.5,
                  height: height * 0.06,
                  text: _buttonNames[index],
                  onPressed: () {
                    switch (index) {
                      case 0:
                        {
                          Navigator.pushNamed(
                              context, Screens.addProductScreen);
                          break;
                        }
                      case 1:
                        {
                          break;
                        }
                      case 2:
                        {
                          break;
                        }
                    }
                  },
                ),
              ),
            )),
      ),
    );
  }
}

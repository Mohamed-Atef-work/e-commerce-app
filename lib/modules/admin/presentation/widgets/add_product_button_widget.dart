import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';

class AddProductButtonWidget extends StatelessWidget {
  const AddProductButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FloatingActionButton(
        backgroundColor: kWhiteGray,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          Navigator.pushNamed(context, Screens.addProductScreen);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}

import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CountingWidget extends StatelessWidget {
  final int num;
  final double? width;
  final double height;
  final void Function() plus;
  final void Function() minus;
  const CountingWidget({
    super.key,
    this.width,
    this.height = 35,
    required this.num,
    required this.plus,
    required this.minus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? context.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: height * 0.71,
            height: height * 0.71,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: InkWell(
              onTap: plus,
              child: const Icon(
                color: Colors.white,
                Icons.add,
              ),
            ),
          ),
          CustomText(
            fontSize: 18,
            text: num.toString(),
            fontFamily: AppStrings.pacifico,
          ),
          Container(
            width: height * 0.71,
            height: height * 0.71,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: InkWell(
              onTap: minus,
              child: const Icon(
                color: Colors.white,
                Icons.remove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

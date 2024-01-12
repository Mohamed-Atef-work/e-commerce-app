import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CountingWidget extends StatelessWidget {
  final int num;
  final void Function() plus;
  final void Function() minus;
  const CountingWidget({
    super.key,
    required this.num,
    required this.plus,
    required this.minus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: context.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 25,
            height: 25,
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
            width: 25,
            height: 25,
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

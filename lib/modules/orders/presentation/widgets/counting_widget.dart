import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CountingWidget extends StatelessWidget {
  final int num;
  const CountingWidget(
    this.num, {
    super.key,
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
              onTap: () {
                //widget.num++;
              },
              child: const Icon(
                color: Colors.white,
                Icons.add,
              ),
            ),
          ),
          CustomText(text: num.toString()),
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: InkWell(
              onTap: () {
                // if (widget.num > 1) {
                // widget.num--;
                //}
              },
              child: const Icon(
                color: Colors.white,
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: context.width * 0.15,
                height: context.height * 0.1,
                margin: const EdgeInsets.only(right: 7),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Image.asset(
                  fit: BoxFit.cover,
                  Images.orderImage,
                  color: AppColors.darkBrown.withOpacity(0.001),
                ),
              ),
              Column(
                children: [
                  const CustomText(
                    text: "Name",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  const CustomText(
                    text: "2035-4-5",
                    fontSize: 15,
                    textColor: AppColors.darkBrown,
                  ),
                ],
              ),
              const Spacer(),
              const CustomText(
                text: "Price \$",
                fontSize: 25,
                textColor: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.black,
            endIndent: context.width * 0.1,
            indent: context.width * 0.1,
          ),
        ],
      ),
    );
  }
}

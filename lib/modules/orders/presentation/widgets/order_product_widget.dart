import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItemEntity item;
  const OrderItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: context.width * 0.2,
            height: context.height * 0.12,
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(item.product.image, fit: BoxFit.contain),
          ),
          Column(
            children: [
              CustomText(
                fontSize: 20,
                text: item.product.name,
                textAlign: TextAlign.left,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold,
                fontFamily: AppStrings.pacifico,
              ),
              SizedBox(height: context.height * 0.03),
              CustomText(
                fontSize: 18,
                //textAlign: TextAlign.,
                fontWeight: FontWeight.bold,
                textColor: AppColors.darkBrown,
                text: "\$${item.product.price * item.quantity}",
              ),
            ],
          ),
          const Spacer(),
          CustomText(
            fontSize: 18,
            //textAlign: TextAlign.,
            fontWeight: FontWeight.bold,
            textColor: AppColors.darkBrown,
            fontFamily: AppStrings.pacifico,
            text: "${item.quantity} ${AppStrings.pieces}",
          ),
        ],
      ),
    );
  }
}

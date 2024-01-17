import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItemEntity item;
  const OrderItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: context.width * 0.2,
              height: context.height * 0.12,
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                item.product.image,
                fit: BoxFit.contain,
              ),
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
                SizedBox(
                  //width: context.width * 0.6,
                  height: context.height * 0.03,
                ),
                CustomText(
                  fontSize: 18,
                  //textAlign: TextAlign.,
                  fontWeight: FontWeight.bold,
                  text: "\$${item.product.price * item.quantity}",
                  textColor: AppColors.darkBrown,
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
        Divider(
          height: 20,
          thickness: 0.5,
          color: Colors.black,
          indent: context.width * 0.05,
          endIndent: context.width * 0.05,
        ),
      ],
    );
  }
}

import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
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
                  fontSize: 18,
                  text: item.product.name,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black,
                ),
                SizedBox(
                  width: context.width * 0.6,
                  height: context.height * 0.03,
                ),
                CountingWidget(item.quantity),
              ],
            ),
            CustomText(
              fontSize: 18,
              //textAlign: TextAlign.,
              fontWeight: FontWeight.bold,
              text: "\$${item.product.price}",
              textColor: AppColors.darkBrown,
            ),
          ],
        ),
        Divider(
          height: 20,
          thickness: 0.5,
          color: Colors.black,
          indent: context.width * 0.1,
          endIndent: context.width * 0.1,
        ),
      ],
    );
  }
}

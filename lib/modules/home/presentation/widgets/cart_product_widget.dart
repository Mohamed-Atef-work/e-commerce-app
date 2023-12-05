import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class CartProductWidget extends StatelessWidget {
  final ProductEntity product;
  final void Function() onPressed;

  const CartProductWidget({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          onPressed: onPressed,
          icon: Container(
            width: 180,
            height: 167,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(product.image, fit: BoxFit.cover),
          ),
          label: SizedBox(
            width: double.infinity,
            height: 165,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: product.name,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.left,
                  fontSize: 20,
                  textColor: Colors.black,
                ),
                CustomText(
                  text: "${product.price} \$",
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textColor: Colors.black,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                CustomText(
                  text: product.category,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textColor: Colors.black,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 20,
          thickness: 0.5,
          color: Colors.black,
          endIndent: context.width * 0.2,
          indent: context.width * 0.2,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'custom_text.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class ProductComponent extends StatelessWidget {
  final ProductEntity product;
  final void Function() onPressed;

  const ProductComponent({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteGray,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: product.id!,
              child: Container(
                height: height * 0.26,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: Svg(Images.loading), // Local placeholder image
                  image: NetworkImage(product.image), // Network image URL
                ),
              ),
            ),
            CustomText(
              fontSize: 16,
              text: product.name,
              textColor: Colors.black,
            ),
            CustomText(
              fontSize: 16,
              textColor: Colors.black,
              text: "\$${product.price}",
            ),
            SizedBox(height: height * 0.001),
          ],
        ),
      ),
    );
  }
}

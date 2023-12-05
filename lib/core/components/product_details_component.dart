import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';

import '../../modules/admin/domain/entities/product_entity.dart';
import 'custom_text.dart';

class ProductWithMoreDetailsComponent extends StatelessWidget {
  final ProductEntity product;
  final double imageWidth;
  final double imageHeight;
  const ProductWithMoreDetailsComponent({
    super.key,
    required this.product,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Screens.productsOfCategory,
          arguments: product,
        );
        print(product.id);
        print(product.category);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange.shade300),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: product.name,
              fontSize: 16,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: "\$${product.price}",
              fontSize: 16,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

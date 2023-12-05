import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';

import '../../../../core/components/custom_text.dart';

class AdminProductWidget extends StatelessWidget {
  final ProductEntity product;

  const AdminProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.orange.shade300,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Screens.adminProductDetailsScreen,
            arguments: product,
          );
        },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              product.image,
              width: width * 0.48,
              height: height * 0.25,
              fit: BoxFit.cover,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: product.name,
              fontSize: 16,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: product.category,
              fontSize: 16,
              textColor: Colors.grey,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: "\$${product.price}",
              fontSize: 16,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

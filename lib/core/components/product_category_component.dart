import 'package:flutter/material.dart';

import '../../modules/admin/domain/entities/product_category_entity.dart';
import 'custom_text.dart';

class CategoryComponent extends StatelessWidget {
  final void Function() onTap;
  final ProductCategoryEntity category;
  final Color backgroundColor;
  final Color iconAndTextColor;

  const CategoryComponent({
    super.key,
    required this.onTap,
    required this.category,
    required this.backgroundColor,
    required this.iconAndTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              fontSize: 18,
              text: category.name,
              textColor: iconAndTextColor,
              textAlign: TextAlign.center,
            ),
            //SizedBox(width: context.width * 0.01),
          ],
        ),
      ),
    );
  }
}

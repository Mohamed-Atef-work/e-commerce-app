import 'package:e_commerce_app/modules/admin/presentation/widgets/edite_delete_category_model_sheet_widget.dart';
import 'package:flutter/material.dart';

import '../../modules/admin/domain/entities/product_category_entity.dart';
import 'custom_text.dart';

class AdminCategoryComponent extends StatelessWidget {
  final void Function() onTap;
  final Color backgroundColor;
  final Color iconAndTextColor;
  final ProductCategoryEntity category;

  const AdminCategoryComponent({
    super.key,
    required this.onTap,
    required this.category,
    required this.backgroundColor,
    required this.iconAndTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) =>
              DeleteUpdateCategoryModelSheetWidget(category: category),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: 18,
              text: category.name,
              textColor: iconAndTextColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class UserCategoryComponent extends StatelessWidget {
  final void Function() onTap;
  final Color backgroundColor;
  final Color iconAndTextColor;
  final ProductCategoryEntity category;

  const UserCategoryComponent({
    super.key,
    required this.onTap,
    required this.category,
    required this.backgroundColor,
    required this.iconAndTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: 18,
              text: category.name,
              textColor: iconAndTextColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

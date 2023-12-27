import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:flutter/material.dart';

import 'favorite_product_widget.dart';

class FavoriteWidget extends StatelessWidget {
  final FavoriteEntity favoriteEntity;
  const FavoriteWidget({
    Key? key,
    required this.favoriteEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            CustomText(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.pacifico,
              text: favoriteEntity.category,
            ),
            SizedBox(height: context.height * 0.01),
          ] +
          List.generate(
            favoriteEntity.products.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: context.width * 0.01),
              child: FavoriteProductWidget(
                onPressed: () {
                  Navigator.pushNamed(context, Screens.productsOfCategory,
                      arguments: favoriteEntity.products[index]);
                },
                product: favoriteEntity.products[index],
              ),
            ),
          ),
    );
  }
}

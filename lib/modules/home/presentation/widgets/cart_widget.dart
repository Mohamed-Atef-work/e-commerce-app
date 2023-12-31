import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/cart_product_widget.dart';
import 'package:flutter/material.dart';

import 'favorite_product_widget.dart';

class CartWidget extends StatelessWidget {
  final CartEntity cartEntity;
  const CartWidget({
    Key? key,
    required this.cartEntity,
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
              text: cartEntity.category,
            ),
            SizedBox(height: context.height * 0.01),
          ] +
          List.generate(
            cartEntity.products.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: context.width * 0.01),
              child: CartProductWidget(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Screens.detailsScreen,
                    arguments: cartEntity.products[index],
                  );
                },
                product: cartEntity.products[index],
              ),
            ),
          ),
    );
  }
}

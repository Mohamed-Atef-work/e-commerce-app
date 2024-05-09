import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/cart_product_widget.dart';
import 'package:flutter/material.dart';

/*class CartWidget extends StatelessWidget {
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
              fontFamily: kPacifico,
              text: cartEntity.category,
            ),
            SizedBox(height: context.height * 0.01),
          ] +
          List.generate(
            cartEntity.products.length,
            (index) => CartProductWidget(
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
    );
  }
}*/

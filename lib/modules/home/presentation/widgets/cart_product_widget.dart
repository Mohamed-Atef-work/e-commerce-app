import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductWidget extends StatelessWidget {
  final int index;
  final ProductEntity product;
  final void Function() onPressed;

  const CartProductWidget({
    super.key,
    required this.product,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.name),
      onDismissed: (direction) {
        /// To Do ooo ooo ooo ooo ooo
        BlocProvider.of<ManageCartProductsCubit>(context)
            .state
            .products
            .removeAt(index);
        BlocProvider.of<ManageCartProductsCubit>(context).deleteFromCart(
          DeleteFromCartParams(
            uId: "uId",
            productId: product.id!,
            category: product.category,
          ),
        );
      },
      background: Container(color: Colors.red),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.width * 0.01),
        child: Column(
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
              endIndent: context.width * 0.1,
              indent: context.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

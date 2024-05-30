import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CartProductWidget extends StatelessWidget {
  final int index;
  //final void Function() onPressed;

  const CartProductWidget(
    this.index, {
    super.key,
    //required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final cartController = BlocProvider.of<ManageCartProductsCubit>(context);
    final detailsController = BlocProvider.of<ProductDetailsCubit>(context);
    final product = cartController.state.products[index].product;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: cartController.state.notExistedProducts.contains(index)
              ? Colors.red
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          detailsController.product(product);
          Navigator.pushNamed(context, Screens.detailsScreen);
        },
        splashColor: Colors.amber,
        // the color is spread gradually, when pressing on.
        highlightColor: Colors.amber,
        // changes all it's color ,after pressing on it .

        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width * 0.32,
              height: height * 0.17,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: product.id!,
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: Svg(Images.loading,
                      ),
                  image: NetworkImage(product.image),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.6,
              height: height * 0.17,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    fontSize: 18,
                    textColor: kDarkBrown,
                    fontWeight: FontWeight.bold,
                    text:
                        "\$${product.price * cartController.state.products[index].quantity}",
                  ),
                  CustomText(
                    maxLines: 2,
                    fontSize: 18,
                    text: product.name,
                    textColor: Colors.black,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CountingWidget(
                    width: double.infinity,
                    plus: () => cartController.quantityPlus(index),
                    minus: () => cartController.quantityMinus(index),
                    num: cartController.state.products[index].quantity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

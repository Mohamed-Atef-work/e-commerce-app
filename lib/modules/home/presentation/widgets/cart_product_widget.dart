import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class CartProductWidget extends StatelessWidget {
  final int index;
  //final void Function() onPressed;

  const CartProductWidget({
    super.key,
    //required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ManageCartProductsCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.01),
      child: InkWell(
        onTap: () {
          BlocProvider.of<ProductDetailsCubit>(context)
              .product(controller.state.products[index].product);
          Navigator.pushNamed(context, Screens.detailsScreen);
        },
        splashColor: Colors.amber.withOpacity(0.5),
        // the color is spread gradually, when pressing on.
        highlightColor: Colors.transparent,
        // changes all it's color ,after pressing on it .
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: context.width * 0.3,
                height: context.height * 0.2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Hero(
                  tag: controller.state.products[index].product.id!,
                  child: Image.network(
                      fit: BoxFit.cover,
                      controller.state.products[index].product.image),
                ),
              ),
              SizedBox(width: context.width * 0.04),
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    text: controller.state.products[index].product.name,
                  ),
                  SizedBox(
                    //width: context.width * 0.6,
                    height: context.height * 0.03,
                  ),
                  CountingWidget(
                    plus: () {
                      controller.quantityPlus(index);
                    },
                    minus: () {
                      controller.quantityMinus(index);
                    },
                    num: controller.state.products[index].quantity,
                  ),
                ],
              ),
              const Spacer(),
              CustomText(
                fontSize: 18,
                //textAlign: TextAlign.,
                fontWeight: FontWeight.bold,
                text:
                    "\$${controller.state.products[index].product.price * controller.state.products[index].quantity}",
                textColor: kDarkBrown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

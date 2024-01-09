import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Dismissible(
      key: ValueKey(controller.state.products[index].name),
      onDismissed: (direction) {
        /// To Do ooo ooo ooo ooo ooo ..uId..
        controller.state.products.removeAt(index);
        controller.deleteFromCart(
          DeleteFromCartParams(
            uId: "uId",
            productId: controller.state.products[index].id!,
            category: controller.state.products[index].category,
          ),
        );
      },
      background: Container(color: Colors.red),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.width * 0.01),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Screens.detailsScreen,
                  arguments: controller.state.products[index],
                );
              },
              icon: Container(
                width: context.width * 0.3,
                height: context.height * 0.2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.network(
                  fit: BoxFit.cover,
                  controller.state.products[index].image,
                ),
              ),
              label: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CustomText(
                        fontSize: 18,
                        textAlign: TextAlign.left,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold,
                        text: controller.state.products[index].name,
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
                        num: controller.state.quantities[index],
                      ),
                    ],
                  ),
                  //Spacer(),
                  CustomText(
                    fontSize: 18,
                    //textAlign: TextAlign.,
                    fontWeight: FontWeight.bold,
                    text:
                        "\$${int.parse(controller.state.products[index].price) * controller.state.quantities[index]}",
                    textColor: AppColors.darkBrown,
                  ),
                ],
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

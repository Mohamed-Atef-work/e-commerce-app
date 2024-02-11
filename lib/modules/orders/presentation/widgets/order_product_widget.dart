import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/core/utils/constants.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  final void Function() onPressed;
  const OrderItemWidget(
      {super.key, required this.index, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    OrderItemsState state = BlocProvider.of<OrderItemsCubit>(context).state;

    return Dismissible(
      key: ValueKey(state.orderItems[index].product.id),
      onDismissed: (_) {
        BlocProvider.of<OrderItemsCubit>(context).deleteItemFromOrder(
          DeleteItemFromOrderParams(
            itemRef: state.orderItems[index].ref!,
          ),
        );
        BlocProvider.of<OrderItemsCubit>(context)
            .state
            .orderItems
            .removeAt(index);
      },
      background: const DismissibleBackgroundComponent(
          color: Colors.red, icon: Icons.delete),
      secondaryBackground: const DismissibleSecondaryBackgroundComponent(
          color: Colors.red, icon: Icons.delete),
      child: InkWell(
        onTap: onPressed,
        //hoverColor: Colors.transparent,
        // when putting the mouse on it .
        splashColor: AppColors.whiteGray,
        // the color is spread gradually, when pressing on.
        highlightColor: Colors.transparent,
        // changes all it's color ,after pressing on it .
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: context.width * 0.2,
                height: context.height * 0.12,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(state.orderItems[index].product.image,
                    fit: BoxFit.contain),
              ),
              Column(
                children: [
                  CustomText(
                    fontSize: 20,
                    textAlign: TextAlign.left,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: kPacifico,
                    text: state.orderItems[index].product.name,
                  ),
                  SizedBox(height: context.height * 0.03),
                  CustomText(
                    fontSize: 18,
                    //textAlign: TextAlign.,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                    text:
                        "\$${state.orderItems[index].product.price * state.orderItems[index].quantity}",
                  ),
                ],
              ),
              const Spacer(),
              CustomText(
                fontSize: 18,
                //textAlign: TextAlign.,
                fontWeight: FontWeight.bold,
                textColor: AppColors.darkBrown,
                fontFamily: kPacifico,
                text:
                    "${state.orderItems[index].quantity} ${AppStrings.pieces}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

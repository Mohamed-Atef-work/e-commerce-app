import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  final void Function() onPressed;
  const OrderItemWidget({
    super.key,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<OrderItemsCubit>(context);
    final order = controller.state.orderItems[index];

    return Dismissible(
      background: _background(),
      secondaryBackground: _secondaryBackground(),
      key: ValueKey(order.product.id),
      onDismissed: (_) {
        final params = DeleteItemFromOrderParams(itemRef: order.ref!);
        controller.deleteItemFromOrder(params);
        controller.state.orderItems.removeAt(index);
      },
      child: InkWell(
        onTap: onPressed,
        //hoverColor: Colors.transparent,
        // when putting the mouse on it .
        splashColor: kWhiteGray,
        // the color is spread gradually, when pressing on.
        highlightColor: Colors.transparent,
        // changes all it's color ,after pressing on it .
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Hero(
                tag: order.product.id!,
                child: Container(
                  width: context.width * 0.25,
                  clipBehavior: Clip.antiAlias,
                  height: context.height * 0.12,
                  margin: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    placeholder: Svg(Images.loading),
                    image: NetworkImage(order.product.image),
                  ),
                ),
              ),
              Column(
                children: [
                  CustomText(
                    fontSize: 20,
                    fontFamily: kPacifico,
                    textColor: Colors.black,
                    text: order.product.name,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: context.height * 0.03),
                  CustomText(
                    fontSize: 18,
                    textColor: kDarkBrown,
                    fontWeight: FontWeight.bold,
                    text: "\$${order.product.price * order.quantity}",
                  ),
                ],
              ),
              const Spacer(),
              CustomText(
                fontSize: 18,
                textColor: kDarkBrown,
                fontFamily: kPacifico,
                fontWeight: FontWeight.bold,
                text: "${order.quantity} ${AppStrings.pieces}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  _background() => const DismissibleBackgroundComponent(
      color: Colors.red, icon: Icons.delete);

  _secondaryBackground() => const DismissibleSecondaryBackgroundComponent(
      color: Colors.red, icon: Icons.delete);
}

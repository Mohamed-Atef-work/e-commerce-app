import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWidget extends StatelessWidget {
  final OrderDataEntity order;
  const OrderWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ManageUserOrdersCubit>(context)
            .getOrderItems(order.reference!);
        BlocProvider.of<ManageUserOrderViewCubit>(context).viewOrderItems();
      },
      splashColor: Colors.black12,
      highlightColor: Colors.black12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: context.width * 0.15,
                  height: context.height * 0.1,
                  margin: const EdgeInsets.only(right: 7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    fit: BoxFit.contain,
                    Images.orderImage,
                    color: AppColors.darkBrown.withOpacity(0.001),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: order.name,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.darkBrown,
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    CustomText(
                      text: order.date,
                      fontSize: 15,
                      textColor: AppColors.darkBrown,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const CustomText(
                      fontSize: 22,
                      textColor: Colors.lightGreen,
                      text: "\$",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      fontSize: 22,
                      textColor: Colors.black,
                      text: order.totalPrice,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 0.5,
              color: Colors.black,
              indent: context.width * 0.1,
              endIndent: context.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

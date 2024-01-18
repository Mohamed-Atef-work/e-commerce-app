import 'package:e_commerce_app/core/utils/app_strings.dart';
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
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              width: context.width * 0.15,
              height: context.height * 0.1,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(right: 7),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                Images.orderImage,
                fit: BoxFit.contain,
                color: AppColors.darkBrown.withOpacity(0.001),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: 18,
                  text: order.name,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.darkBrown,
                ),
                SizedBox(height: context.height * 0.01),
                CustomText(
                  fontSize: 15,
                  text: order.date,
                  textColor: AppColors.darkBrown,
                ),
              ],
            ),
            const Spacer(),
            CustomText(
              fontSize: 22,
              textColor: AppColors.black,
              fontWeight: FontWeight.bold,
              text: "\$${order.totalPrice}",
              fontFamily: AppStrings.pacifico,
            ),
          ],
        ),
      ),
    );
  }
}

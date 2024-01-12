import 'package:e_commerce_app/core/components/delete_dismissible_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_product_widget.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';

class ViewUserOrderItemsBody extends StatelessWidget {
  const ViewUserOrderItemsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageUserOrdersCubit, ManageUserOrdersState>(
      builder: (context, state) {
        if (state.getOrderItems == RequestState.loading ||
            state.deleteOrderItem == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.getOrderItems != RequestState.loading &&
            state.orderItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppStrings.pacifico,
                  text: AppStrings.thisOrderIsNoLongerExisted,
                ),
                CustomButton(
                  text: AppStrings.ok,
                  fontFamily: AppStrings.pacifico,
                  onPressed: () {
                    BlocProvider.of<ManageUserOrderViewCubit>(context)
                        .viewOrders();
                  },
                  width: context.height * 0.1,
                  height: context.height * 0.05,
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: state.orderItems.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (_) {
                BlocProvider.of<ManageUserOrdersCubit>(context)
                    .deleteItemFromOrder(
                  DeleteItemFromOrderParams(
                    itemRef: state.orderItems[index].ref!,
                  ),
                );
                BlocProvider.of<ManageUserOrdersCubit>(context)
                    .state
                    .orderItems
                    .removeAt(index);
              },
              background: const DeleteDismissibleBackgroundComponent(),
              key: ValueKey(state.orderItems[index].product.id),
              child: OrderItemWidget(state.orderItems[index]),
            ),
          );
        }
      },
    );
  }
}

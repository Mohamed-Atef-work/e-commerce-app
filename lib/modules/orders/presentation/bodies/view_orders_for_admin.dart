import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';

class ViewOrdersForAdmin extends StatelessWidget {
  const ViewOrdersForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserOrdersCubit, GetUserOrdersState>(
        builder: (context, state) {
      final controller = BlocProvider.of<ManageAdminOrderViewCubit>(context);
      if (state.deleteOrder == RequestState.loading ||
          state.getOrders == RequestState.loading) {
        return const LoadingWidget();
      } else if (state.getOrders == RequestState.success &&
          state.orders.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.viewUsers(),
              ),
            ),
            const Expanded(
                child: MessengerComponent(AppStrings.noOrdersForThisUser)),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.viewUsers(),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: state.orders.length,
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => OrderWidget(
                  index: index,
                  onPressed: () {
                    BlocProvider.of<OrderItemsCubit>(context)
                        .getOrderItems(state.orders[index].reference!);
                    controller.viewOrderItems();
                  },
                ),
                separatorBuilder: (_, __) => const DividerComponent(),
              ),
            ),
          ],
        );
      }
    });
  }
}

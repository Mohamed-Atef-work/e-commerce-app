import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';

class ViewUserOrdersBody extends StatelessWidget {
  const ViewUserOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserOrdersCubit, GetUserOrdersState>(
        listener: _listener,
        builder: (_, state) {
          if (state.deleteOrder == RequestState.loading ||
              state.getOrders == RequestState.loading) {
            return const LoadingWidget();
          } else if (state.getOrders == RequestState.success &&
              state.orders.isEmpty) {
            return const MessengerComponent(AppStrings.noOrdersForThisUser);
          } else {
            return ListView.separated(
              itemCount: state.orders.length,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => OrderWidget(
                index: index,
                onPressed: () {
                  BlocProvider.of<OrderItemsCubit>(context)
                      .getOrderItems(state.orders[index].reference!);
                  BlocProvider.of<ManageUserOrderViewCubit>(context)
                      .viewOrderItems();
                },
              ),
              separatorBuilder: (_, __) => const DividerComponent(),
            );
          }
        });
  }

  void _listener(BuildContext context, GetUserOrdersState state) {
    if (state.getOrders == RequestState.error) {
      showMyToast(state.message, context, Colors.red);
    } else if (state.deleteOrder == RequestState.success) {
      showMyToast(AppStrings.orderDeleted(), context, Colors.green);
    } else if (state.deleteOrder == RequestState.error) {
      showMyToast(state.message, context, Colors.red);
    }
  }
}

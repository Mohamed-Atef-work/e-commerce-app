import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/services/service_locator/init.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_orders.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_order_items.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ManageUserOrderViewCubit>()),
        BlocProvider(
          create: (context) => sl<ManageUserOrdersCubit>()..getOrders("uId"),
        ),
        BlocProvider(
          create: (context) => sl<GetUserOrdersCubit>()..getOrders("uId"),
        ),
        BlocProvider(create: (context) => sl<OrderItemsCubit>()),
      ],
      child: BlocBuilder<ManageUserOrderViewCubit, ManageUserOrderViewState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: state.orderState == UserOrderViewState.viewOrders
                ? const ViewUserOrdersBody()
                : const ViewUserOrderItemsBody(),
          );
        },
      ),
    );
  }

  _body(BuildContext context) {
    final state = BlocProvider.of<ManageUserOrderViewCubit>(context).state;
    if (state.orderState == UserOrderViewState.viewOrders) {
      return const ViewUserOrdersBody();
    } else {
      return const ViewUserOrderItemsBody();
    }
  }

  _appBar(BuildContext context) {
    final state = BlocProvider.of<ManageUserOrderViewCubit>(context).state;

    return appBar(
      title: AppStrings.order,
      leading: IconButton(
        onPressed: () {
          if (state.orderState == UserOrderViewState.viewOrderItems) {
            BlocProvider.of<ManageUserOrderViewCubit>(context).viewOrders();
          } else {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}

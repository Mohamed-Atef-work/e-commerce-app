import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_user_orders.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_user_order_products.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';

class AdminOrderView extends StatelessWidget {
  const AdminOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ManageUserOrderViewCubit>()),
        BlocProvider(
          create: (context) => sl<ManageUserOrdersCubit>()..getOrders("uId"),
        ),
      ],
      child: BlocBuilder<ManageUserOrderViewCubit, ManageUserOrderViewState>(
        builder: (BuildContext context, state) {
          if (state.orderState == UserOrderViewState.viewOrders) {
            return const ViewUserOrdersBody();
          } else {
            return const ViewUserOrderItemsBody();
          }
        },
      ),
    );
  }
}

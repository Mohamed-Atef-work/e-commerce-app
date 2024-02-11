import 'package:e_commerce_app/modules/orders/presentation/bodies/view_orders_for_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_users_who_ordered.dart';
import 'package:e_commerce_app/modules/orders/presentation/bodies/view_order_items_for_admin.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_users_who_ordered_controller/get_users_who_ordered_cubit.dart';

class AdminOrderView extends StatelessWidget {
  const AdminOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Provide the controller .............................................
        BlocProvider(
          create: (context) => sl<ManageAdminOrderViewCubit>(),
        ),
        BlocProvider(
            create: (context) => sl<GetUsersWhoOrderedCubit>()..getUsersTwo()),
        BlocProvider(
          create: (context) => sl<GetUserOrdersCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<OrderItemsCubit>(),
        ),
      ],
      child: BlocBuilder<ManageAdminOrderViewCubit, ManageAdminOrderViewState>(
        builder: (BuildContext context, state) {
          if (state.view == AdminOrderViewState.users) {
            return const ViewUsersWhoOrderedBody();
          } else if (state.view == AdminOrderViewState.userOrders) {
            return const ViewOrdersForAdmin();
          } else {
            return const ViewOrderItemsForAdmin();
          }
        },
      ),
    );
  }
}

import 'package:e_commerce_app/modules/orders/presentation/controller/get_users_who_ordered_controller/get_users_who_ordered_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ViewUsersWhoOrderedBody extends StatelessWidget {
  const ViewUsersWhoOrderedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersWhoOrderedCubit, GetUsersWhoOrderedState>(
      builder: (context, state) {
        if (state.usersDataState == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.usersDataState == RequestState.success &&
            state.usersData.isEmpty) {
          return const MessengerComponent(AppStrings.noUsersOrdered);
        } else {
          return ListView.separated(
            itemCount: state.usersData.length,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => TextButton(
              onPressed: () {
                /// ..............................................................
                BlocProvider.of<GetUserOrdersCubit>(context)
                    .getOrders(state.usersData[index].id);
                BlocProvider.of<ManageAdminOrderViewCubit>(context)
                    .viewOrders();
              },
              child: Text(state.usersData[index].email),
            ),
            separatorBuilder: (context, index) => const DividerComponent(),
          );
        }
      },
    );
  }
}

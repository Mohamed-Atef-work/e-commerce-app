import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_users_who_ordered_controller/get_users_who_ordered_cubit.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ViewUsersWhoOrderedBody extends StatelessWidget {
  const ViewUsersWhoOrderedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersWhoOrderedCubit, GetUsersWhoOrderedState>(
        builder: (context, state) {
      if (state.usersState == RequestState.loading) {
        return const LoadingWidget();
      } else if (state.usersState == RequestState.success &&
          state.users.isEmpty) {
        return const Center(
          child: CustomText(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: AppStrings.pacifico,
            text: AppStrings.thereIsNoOrders,
          ),
        );
      } else {
        return ListView.separated(
          itemCount: state.users.length,
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => TextButton(
            onPressed: () {
              /// ..............................................................
              BlocProvider.of<GetUserOrdersCubit>(context)
                  .getOrders(state.users[index].id);
              BlocProvider.of<ManageAdminOrderViewCubit>(context).viewOrders();
            },
            child: Text(state.users[index].email),
          ),
          separatorBuilder: (context, index) => const DividerComponent(),
        );
      }
    });
  }
}

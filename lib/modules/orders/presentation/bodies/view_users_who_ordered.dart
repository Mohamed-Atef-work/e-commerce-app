import 'package:e_commerce_app/modules/orders/presentation/controller/get_users_who_ordered_controller/get_users_who_ordered_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/user_who_ordered_widget.dart';
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
      builder: (_, state) {
        if (state.usersDataState == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.usersDataState == RequestState.success &&
            state.usersData.isEmpty) {
          return const MessengerComponent(AppStrings.noUsersOrdered);
        } else if (state.usersDataState == RequestState.success &&
            state.usersData.isNotEmpty) {
          return ListView.separated(
            itemCount: state.usersData.length,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                UserWhoOrderedWidget(state.usersData[index]),
            separatorBuilder: (context, index) => const DividerComponent(),
          );
        } else {
          return const MessengerComponent(AppStrings.ops);
        }
      },
    );
  }
}

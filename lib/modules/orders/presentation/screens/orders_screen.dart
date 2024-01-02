import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewUserOrdersScreen extends StatelessWidget {
  const ViewUserOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetUserOrdersCubit>()..getOrderItems("uId"),
      child: Scaffold(
        appBar: appBar(title: AppStrings.order),
        backgroundColor: AppColors.primaryColorYellow,
        body: BlocBuilder<GetUserOrdersCubit, GetUserOrdersState>(
          builder: (context, state) {
            if (state.ordersState == RequestState.success) {
              return ListView.builder(
                itemCount: state.orders.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    OrderWidget(state.orders[index]),
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}

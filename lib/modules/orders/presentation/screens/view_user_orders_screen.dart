import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewUserOrdersScreen extends StatelessWidget {
  const ViewUserOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ManageUserOrdersCubit>()..getOrderItems("uId"),
      child: Scaffold(
        appBar: appBar(title: AppStrings.yourOrders),
        backgroundColor: AppColors.primaryColorYellow,
        body: BlocBuilder<ManageUserOrdersCubit, ManageUserOrdersState>(
          builder: (context, state) {
            if (state.getOrdersState == RequestState.success) {
              return ListView.builder(
                itemCount: state.orders.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Dismissible(
                    onDismissed: (_) {
                      BlocProvider.of<ManageUserOrdersCubit>(context)
                          .deleteOrder(
                        DeleteOrderParams(
                            orderRef: state.orders[index].reference!),
                      );
                      BlocProvider.of<ManageUserOrdersCubit>(context)
                          .state
                          .orders
                          .removeAt(index);
                    },
                    background: Container(color: Colors.red),
                    key: ValueKey(state.orders[index].date),
                    child: OrderWidget(state.orders[index])),
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

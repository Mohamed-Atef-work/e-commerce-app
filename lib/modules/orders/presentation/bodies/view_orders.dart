import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_order_view/user_order_view_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';

class ViewUserOrdersBody extends StatelessWidget {
  const ViewUserOrdersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserOrdersCubit, GetUserOrdersState>(
        builder: (context, state) {
      if (state.deleteOrder == RequestState.loading ||
          state.getOrders == RequestState.loading) {
        return const LoadingWidget();
      } else if (state.getOrders == RequestState.success &&
          state.orders.isEmpty) {
        return const Center(
          child: CustomText(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: AppStrings.pacifico,
            text: AppStrings.youHaveNoOrders,
          ),
        );
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
          separatorBuilder: (context, index) => const DividerComponent(),
        );
      }
    });
  }
}

/*class ViewUserOrdersBody extends StatelessWidget {
  const ViewUserOrdersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageUserOrdersCubit, ManageUserOrdersState>(
        builder: (context, state) {
      if (state.deleteOrder == RequestState.loading ||
          state.getOrders == RequestState.loading) {
        return const LoadingWidget();
      } else if (state.getOrders == RequestState.success &&
          state.orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: AppStrings.pacifico,
                text: AppStrings.youHaveNoOrders,
              ),
              CustomButton(
                text: AppStrings.ok,
                fontFamily: AppStrings.pacifico,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Screens.homeScreen, (route) => false);
                },
                width: context.height * 0.1,
                height: context.height * 0.05,
              ),
            ],
          ),
        );
      } else {
        return ListView.separated(
          separatorBuilder: (context, index) => const DividerComponent(),
          itemCount: state.orders.length,
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Dismissible(
            onDismissed: (DismissDirection direction) {
              //if (direction == DismissDirection.startToEnd) {
              BlocProvider.of<ManageUserOrdersCubit>(context)
                  .dismissOrder(index);
              //}
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                BlocProvider.of<ManageUserOrdersCubit>(context).deleteOrder(
                  DeleteOrderParams(orderRef: state.orders[index].reference!),
                );
                return true;
              } else {
                showBottomSheet(
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => sl<UpdateOrderDataCubit>()
                      ..orderData(state.orders[index]),
                    child: const UpDateOrderDataWidget(),
                  ),
                );
                return false;
              }
            },
            secondaryBackground: const DismissibleSecondaryBackgroundComponent(
                color: Colors.green, icon: Icons.edit),
            background: const DismissibleBackgroundComponent(
                color: Colors.red, icon: Icons.delete),
            key: ValueKey(state.orders[index].reference),
            child: OrderWidget(state.orders[index]),
          ),
        );
      }
    });
  }
}*/
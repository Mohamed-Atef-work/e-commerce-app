import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_product_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';

class ViewUserOrderItemsBody extends StatelessWidget {
  const ViewUserOrderItemsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderItemsCubit, OrderItemsState>(
      builder: (context, state) {
        if (state.getOrderItems == RequestState.loading ||
            state.deleteOrderItem == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.getOrderItems != RequestState.loading &&
            state.orderItems.isEmpty) {
          return const Center(
            child: CustomText(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.pacifico,
              text: AppStrings.thisOrderIsNoLongerExisted,
            ),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: state.orderItems.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => OrderItemWidget(
              index: index,
              onPressed: () {
                BlocProvider.of<ProductDetailsCubit>(context)
                    .product(state.orderItems[index].product);
                Navigator.pushNamed(context, Screens.detailsScreen);
              },
            ),
            separatorBuilder: (context, index) => const DividerComponent(),
          );
        }
      },
    );
  }
}

/*class ViewUserOrderItemsBody extends StatelessWidget {
  const ViewUserOrderItemsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageUserOrdersCubit, ManageUserOrdersState>(
      builder: (context, state) {
        if (state.getOrderItems == RequestState.loading ||
            state.deleteOrderItem == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.getOrderItems != RequestState.loading &&
            state.orderItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppStrings.pacifico,
                  text: AppStrings.thisOrderIsNoLongerExisted,
                ),
                CustomButton(
                  text: AppStrings.ok,
                  fontFamily: AppStrings.pacifico,
                  onPressed: () {
                    BlocProvider.of<ManageUserOrderViewCubit>(context)
                        .viewOrders();
                  },
                  width: context.height * 0.1,
                  height: context.height * 0.05,
                ),
              ],
            ),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: state.orderItems.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(state.orderItems[index].product.id),
              onDismissed: (_) {
                BlocProvider.of<ManageUserOrdersCubit>(context)
                    .deleteItemFromOrder(
                  DeleteItemFromOrderParams(
                    itemRef: state.orderItems[index].ref!,
                  ),
                );
                BlocProvider.of<ManageUserOrdersCubit>(context)
                    .state
                    .orderItems
                    .removeAt(index);
              },
              background: const DismissibleBackgroundComponent(
                  color: Colors.red, icon: Icons.delete),
              secondaryBackground:
                  const DismissibleSecondaryBackgroundComponent(
                      color: Colors.red, icon: Icons.delete),
              child: OrderItemWidget(state.orderItems[index]),
            ),
            separatorBuilder: (context, index) => const DividerComponent(),
          );
        }
      },
    );
  }
}*/

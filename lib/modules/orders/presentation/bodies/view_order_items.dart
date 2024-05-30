import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_product_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';

class ViewUserOrderItemsBody extends StatelessWidget {
  const ViewUserOrderItemsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderItemsCubit, OrderItemsState>(
      listenWhen: _listenWhen,
      listener: _listener,
      builder: (_, state) {
        if (state.getOrderItems == RequestState.loading ||
            state.deleteOrderItem == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.getOrderItems == RequestState.success &&
            state.orderItems.isEmpty) {
          return const MessengerComponent(
              AppStrings.thisOrderIsNoLongerExisted);
        } else if (state.getOrderItems == RequestState.error) {
          return MessengerComponent(state.message);
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: state.orderItems.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => OrderItemWidget(
              index: index,
              onPressed: () {
                final product = state.orderItems[index].product;
                BlocProvider.of<ProductDetailsCubit>(context).product(product);
                Navigator.pushNamed(context, Screens.detailsScreen);
              },
            ),
            separatorBuilder: (_, __) => const DividerComponent(),
          );
        }
      },
    );
  }

  void _listener(BuildContext context, OrderItemsState state) {
    if (state.deleteOrderItem == RequestState.error) {
      showMyToast(state.message, context, Colors.red);
    } else if (state.getOrderItems == RequestState.error) {
      showMyToast(state.message, context, Colors.red);
    } else if (state.deleteOrderItem == RequestState.success) {
      showMyToast(AppStrings.itemDeleted(), context, Colors.green);
    }
  }

  bool _listenWhen(OrderItemsState previous, OrderItemsState current) =>
      current.deleteOrderItem != previous.deleteOrderItem ||
      current.getOrderItems != previous.getOrderItems;
}

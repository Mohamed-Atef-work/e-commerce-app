import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_product_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/order_items_controller/order_items_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';

class ViewOrderItemsForAdmin extends StatelessWidget {
  const ViewOrderItemsForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderItemsCubit, OrderItemsState>(
      builder: (context, state) {
        if (state.getOrderItems == RequestState.loading ||
            state.deleteOrderItem == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.getOrderItems != RequestState.loading &&
            state.orderItems.isEmpty) {
          return const NotExistedOrderWidget();
        } else {
          return ItemsWidget(state.orderItems);
        }
      },
    );
  }
}

class NotExistedOrderWidget extends StatelessWidget {
  const NotExistedOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewsController =
        BlocProvider.of<ManageAdminOrderViewCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => orderViewsController.viewOrders(),
          ),
        ),
        const Expanded(
          child: MessengerComponent(AppStrings.thisOrderIsNoLongerExisted),
        ),
      ],
    );
  }
}

class ItemsWidget extends StatelessWidget {
  final List<OrderItemEntity> orderItems;
  const ItemsWidget(this.orderItems, {super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = BlocProvider.of<AdminDetailsCubit>(context);

    final orderViewsController =
        BlocProvider.of<ManageAdminOrderViewCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => orderViewsController.viewOrders(),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: orderItems.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => OrderItemWidget(
              index: index,
              onPressed: () {
                final product = orderItems[index].product;
                detailsController.product(product);
                Navigator.pushNamed(context, Screens.adminDetailsScreen);
              },
            ),
            separatorBuilder: (_, __) => const DividerComponent(),
          ),
        ),
      ],
    );
  }
}

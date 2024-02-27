import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ManageAdminOrderViewCubit>(context)
                          .viewOrders();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const Expanded(
                child: MessengerComponent(
                    mess: AppStrings.thisOrderIsNoLongerExisted),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ManageAdminOrderViewCubit>(context)
                          .viewOrders();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.orderItems.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => OrderItemWidget(
                    index: index,
                    onPressed: () {
                      BlocProvider.of<AdminDetailsCubit>(context)
                          .product(state.orderItems[index].product);
                      Navigator.pushNamed(context, Screens.adminDetailsScreen);
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const DividerComponent(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

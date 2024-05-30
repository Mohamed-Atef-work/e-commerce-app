import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/update_order_data_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';

class OrderWidget extends StatelessWidget {
  final int index;
  final void Function() onPressed;
  const OrderWidget({
    super.key,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final orderController = BlocProvider.of<GetUserOrdersCubit>(context);

    final state = orderController.state;
    SharedUserDataState userDataState =
        BlocProvider.of<SharedUserDataCubit>(context).state;

    final width = context.width;
    final height = context.height;

    final dateTime = state.orders[index].date.split(" ");
    final date = dateTime[0];
    final bigTime = dateTime[1].split(":");
    final time = "${bigTime[0]}:${bigTime[1]}";

    return Dismissible(
      background: _backGround(),
      secondaryBackground: _secondaryBackGround(),
      onDismissed: (DismissDirection direction) =>
          orderController.dismissOrder(index),
      confirmDismiss: (DismissDirection direction) async => _confirmDismiss(
        id: userDataState.sharedEntity!.user.userEntity.id,
        orderController: orderController,
        order: state.orders[index],
        direction: direction,
        context: context,
      ),
      key: ValueKey(state.orders[index].reference),
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.black12,
        highlightColor: Colors.black12,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: SvgPicture.asset(
                  Images.orderImage,
                  width: width * 0.15,
                  height: height * 0.1,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontSize: 18,
                    textColor: kDarkBrown,
                    fontWeight: FontWeight.bold,
                    text: state.orders[index].name,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomText(
                    text: time,
                    fontSize: 15,
                    textColor: kDarkBrown,
                  ),
                  SizedBox(height: height * 0.005),
                  CustomText(
                    text: date,
                    fontSize: 15,
                    textColor: kDarkBrown,
                  ),
                ],
              ),
              const Spacer(),
              CustomText(
                fontSize: 22,
                fontFamily: kPacifico,
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
                text: "\$${state.orders[index].totalPrice}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  _secondaryBackGround() => const DismissibleSecondaryBackgroundComponent(
      color: Colors.green, icon: Icons.edit);

  _backGround() => const DismissibleBackgroundComponent(
      color: Colors.red, icon: Icons.delete);

  _confirmDismiss({
    required String id,
    required BuildContext context,
    required OrderDataEntity order,
    required DismissDirection direction,
    required GetUserOrdersCubit orderController,
  }) {
    if (direction == DismissDirection.startToEnd) {
      final deleteParams =
          DeleteOrderParams(orderRef: order.reference!, uId: id);
      orderController.deleteOrder(deleteParams);
      return true;
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) => BlocProvider(
          create: (_) => sl<UpdateOrderDataCubit>()..orderData(order),
          child: const UpDateOrderDataWidget(),
        ),
      );
      return false;
    }
  }
}

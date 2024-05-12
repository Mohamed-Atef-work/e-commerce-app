import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/update_order_data_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    GetUserOrdersState state =
        BlocProvider.of<GetUserOrdersCubit>(context).state;
    SharedUserDataState userDataState =
        BlocProvider.of<SharedUserDataCubit>(context).state;

    return Dismissible(
      onDismissed: (DismissDirection direction) {
        //if (direction == DismissDirection.startToEnd) {
        BlocProvider.of<GetUserOrdersCubit>(context).dismissOrder(index);
        //}
      },
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          BlocProvider.of<GetUserOrdersCubit>(context).deleteOrder(
            DeleteOrderParams(
                orderRef: state.orders[index].reference!,
                uId: userDataState.sharedEntity!.user.userEntity.id),
          );
          return true;
        } else {
          showModalBottomSheet(
            context: context,
            builder: (context) => BlocProvider(
              create: (context) =>
                  sl<UpdateOrderDataCubit>()..orderData(state.orders[index]),
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
                  width: context.width * 0.15,
                  height: context.height * 0.1,
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
                  SizedBox(height: context.height * 0.01),
                  CustomText(
                    fontSize: 15,
                    textColor: kDarkBrown,
                    text: state.orders[index].date,
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
}

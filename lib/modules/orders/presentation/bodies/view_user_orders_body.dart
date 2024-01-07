import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_user_orders/manage_user_orders_cubit.dart';

class ViewUserOrdersBody extends StatelessWidget {
  const ViewUserOrdersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageUserOrdersCubit, ManageUserOrdersState>(
      builder: (context, state) {
        if (state.getOrders == RequestState.success &&
            state.orders.isNotEmpty) {




          return ListView.builder(
            itemCount: state.orders.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => OrderWidget(state.orders[index]),
          );
        } else if (state.getOrders != RequestState.loading &&
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
          return const LoadingWidget();
        }
      },
    );
  }
}

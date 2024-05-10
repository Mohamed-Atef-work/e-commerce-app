import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/get_user_orders_controller/get_user_orders_cubit.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/manage_admin_order_view/admin_order_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserWhoOrderedWidget extends StatelessWidget {
  final UserEntity user;
  const UserWhoOrderedWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<GetUserOrdersCubit>(context).getOrders(user.id);
        BlocProvider.of<ManageAdminOrderViewCubit>(context).viewOrders();
      },
      splashColor: Colors.black12,
      highlightColor: Colors.black12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.user,
              width: context.width * 0.15,
              height: context.height * 0.1,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: 18,
                  text: user.name,
                  textColor: kDarkBrown,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: context.height * 0.01),
                CustomText(
                  fontSize: 15,
                  text: user.phone!,
                  textColor: kBlack,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: context.height * 0.01),
                CustomText(
                  fontSize: 15,
                  text: user.address!,
                  textColor: kDarkBrown,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

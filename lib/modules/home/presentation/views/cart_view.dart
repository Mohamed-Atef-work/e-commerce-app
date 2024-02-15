import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/cart_product_widget.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manageCartController =
        BlocProvider.of<ManageCartProductsCubit>(context);
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final userEntity = userData.sharedEntity!.user.userEntity;
    return BlocBuilder<ManageCartProductsCubit, ManageCartProductsState>(
        builder: (context, state) {
      if (state.getCart == RequestState.loading ||
          state.addOrder == RequestState.loading ||
          state.clearCart == RequestState.loading ||
          state.deleteFromCart == RequestState.loading ||
          state.getProductsQuantities == RequestState.loading) {
        return const LoadingWidget();
      } else if (state.getCart == RequestState.success &&
          state.products.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.products.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                itemBuilder: (context, index) => Dismissible(
                  background: _background(),
                  key: ValueKey(state.products[index].name),
                  secondaryBackground: _secondaryBackground(),
                  onDismissed: (direction) {
                    /// To Do ooo ooo ooo ooo ooo ..[uId]..
                    manageCartController.deleteFromCart(
                      DeleteFromCartParams(
                        uId: userEntity.id,
                        productId: state.products[index].id!,
                        category: state.products[index].category,
                      ),
                    );
                    state.products.removeAt(index);
                  },
                  child: CartProductWidget(index: index),
                ),
                separatorBuilder: (context, index) => const DividerComponent(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomButton(
                fontSize: 18,
                fontFamily: kPacifico,
                text: AppStrings.checkOut,
                width: context.width * 0.7,
                fontWeight: FontWeight.bold,
                height: context.height * 0.06,
                onPressed: () {
                  if (userEntity.address != null && userEntity.phone != null) {
                    manageCartController.addOrder(userEntity);
                  } else {
                    /// to do error snack bar;
                  }
                },
              ),
            )
          ],
        );
      } else {
        return const Center(
          child: CustomText(
            fontSize: 25,
            fontFamily: kPacifico,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
            text: AppStrings.cartIsEmpty,
          ),
        );
      }
    });
  }

  _background() => const DismissibleBackgroundComponent(
      color: Colors.red, icon: Icons.delete);
}

_secondaryBackground() => const DismissibleSecondaryBackgroundComponent(
    color: Colors.red, icon: Icons.delete);

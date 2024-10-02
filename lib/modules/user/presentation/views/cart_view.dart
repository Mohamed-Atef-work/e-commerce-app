import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/services/stripe/constants.dart';
import 'package:e_commerce_app/core/services/stripe/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/dismissible_background.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/cart_product_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/loading_cart_widget.dart';
import 'package:e_commerce_app/modules/user/domain/params/delete_product_from_cart_params.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final manageCartController =
        BlocProvider.of<ManageCartProductsCubit>(context);
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final userEntity = userData.sharedEntity!.user.userEntity;
    return BlocConsumer<ManageCartProductsCubit, ManageCartProductsState>(
      listener: _listener,
      builder: (_, state) {
        if (state.getCart == RequestState.loading) {
          return const LoadingCartWidget();
        } else if (state.addOrder == RequestState.loading ||
            state.deleteFromCart == RequestState.loading) {
          return const LoadingWidget();
        } else if (state.products.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.products.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  itemBuilder: (_, index) => Dismissible(
                    background: _background(),
                    secondaryBackground: _secondaryBackground(),
                    key: ValueKey(state.products[index].product.name),
                    onDismissed: (direction) {
                      final product = state.products[index].product;
                      final deleteParams = DeleteFromCartParams(
                        uId: userEntity.id,
                        productId: product.id!,
                        category: product.category,
                      );
                      manageCartController.deleteFromCart(deleteParams);
                      state.products.removeAt(index);
                    },
                    child: CartProductWidget(index),
                  ),
                  separatorBuilder: (_, __) => const DividerComponent(),
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
                  onPressed: () async {
                    if (userEntity.address != null &&
                        userEntity.phone != null) {
                      final apiServices = DioServices();
                      final stripe = StripeService(apiServices);
                      await stripe.pay(100, "USD", StripeConstants.customerId);
                      //manageCartController.addOrder(userEntity);
                    } else {
                      showMyToast(
                        AppStrings.pleaseAddPhoneAddress,
                        context,
                        Colors.red,
                        const StyledToastPosition(
                          align: Alignment.bottomCenter,
                          offset: 70,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return const MessengerComponent(AppStrings.cartIsEmpty);
        }
      },
    );
  }

  _background() => const DismissibleBackgroundComponent(
      color: Colors.red, icon: Icons.delete);

  _secondaryBackground() => const DismissibleSecondaryBackgroundComponent(
      color: Colors.red, icon: Icons.delete);

  void _listener(BuildContext context, ManageCartProductsState state) {
    if (state.getCart == RequestState.error ||
        state.addOrder == RequestState.error ||
        state.deleteFromCart == RequestState.error) {
      showMyToast(state.message!, context, Colors.red,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 70));
    } else if (state.addOrder == RequestState.success ||
        state.deleteFromCart == RequestState.success) {
      showMyToast(state.message!, context, Colors.green,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 65));
    }
  }
}

import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsController = BlocProvider.of<ProductDetailsCubit>(context);
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final uId = userData.sharedEntity!.user.userEntity.id;
    return Scaffold(
      backgroundColor: kPrimaryColorYellow,
      appBar: appBar(
        title: AppStrings.details,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            detailsController.reset();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (_, state) {
            _listener(state);
          },
          builder: (context, state) {
            if (state.addToCart == RequestState.loading) {
              return const LoadingWidget();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: context.width * 0.8,
                      height: context.height * 0.45,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.network(
                        fit: BoxFit.fill,
                        state.product!.image,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  CustomText(
                    fontSize: 25,
                    textColor: kDarkBrown,
                    fontFamily: kPacifico,
                    text: state.product!.name,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    fontSize: 20,
                    textColor: kDarkBrown,
                    fontFamily: kPacifico,
                    fontWeight: FontWeight.bold,
                    text: "\$${state.product!.price * state.quantity}",
                  ),
                  SizedBox(height: context.height * 0.03),
                  CustomText(
                    fontSize: 18,
                    textColor: kDarkBrown,
                    text: state.product!.description,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountingWidget(
                        height: 40,
                        num: state.quantity,
                        width: context.width * 0.8,
                        plus: () {
                          detailsController.quantityPlus();
                        },
                        minus: () {
                          detailsController.quantityMinus();
                        },
                      ),
                      HeartWihMangeFavoriteCubitProviderWidget(
                        heartColor: Colors.white,
                        product: state.product!,
                        iconsSize: 35,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      fontSize: 18,
                      fontFamily: kPacifico,
                      text: AppStrings.addToCart,
                      width: context.width * 0.9,
                      fontWeight: FontWeight.bold,
                      height: context.height * 0.07,
                      onPressed: () {
                        /// To Do o o o o o o o
                        detailsController.addToCart(uId);
                        BlocProvider.of<ManageCartProductsCubit>(context)
                            .needToReGet();
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _listener(ProductDetailsState state) {
    if (state.addToCart == RequestState.success) {
      showToast(AppStrings.added, ToastState.success);
    } else if (state.addToCart == RequestState.error) {
      showToast(AppStrings.ops, ToastState.error);
    }
  }
}
/*
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
    ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: kPrimaryColorYellow,
      appBar: appBar(title: AppStrings.details),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: ProductDetailsWidget(product: product)),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              fixedSize: Size(context.width, context.height * 0.08),
            ),
            onPressed: () {
              /// To Do o o o o o o o
              BlocProvider.of<ManageCartProductsCubit>(context).addToCart(
                AddToCartParams(
                  category: state.product!.category,
                  productId: state.product!.id!,
                  uId: 'uId',
                ),
              );
              */
/*final cartStore = CartStoreImpl(FirebaseFirestore.instance);
            cartStore.addToCart(
              AddToCartParams(
                category: state.product!.category,
                productId: state.product!.id!,
                uId: 'uId',
              ),
            );*/ /*

            },
            child: const CustomText(
              fontSize: 20,
              textColor: Colors.white,
              text: AppStrings.addToCart,
              fontWeight: FontWeight.bold,
              fontFamily: kPacifico,
            ),
          ),
        ],
      ),
    );
  }
}*/

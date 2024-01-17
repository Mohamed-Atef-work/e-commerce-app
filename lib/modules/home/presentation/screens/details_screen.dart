import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/counting_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorYellow,
      appBar: appBar(title: AppStrings.details),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state.addToCart == RequestState.loading) {
              return const LoadingWidget();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        state.product!.image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  CustomText(
                    fontSize: 25,
                    text: state.product!.name,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                    fontFamily: AppStrings.pacifico,
                  ),
                  CustomText(
                    fontSize: 20,
                    text: "\$${state.product!.price * state.quantity}",
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                    fontFamily: AppStrings.pacifico,
                  ),
                  SizedBox(height: context.height * 0.03),
                  CustomText(
                    fontSize: 18,
                    text: state.product!.description,
                    textColor: AppColors.darkBrown,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountingWidget(
                        num: state.quantity,
                        height: 40,
                        plus: () {
                          BlocProvider.of<ProductDetailsCubit>(context)
                              .quantityPlus();
                        },
                        minus: () {
                          BlocProvider.of<ProductDetailsCubit>(context)
                              .quantityMinus();
                        },
                        width: context.width * 0.8,
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
                      text: AppStrings.addToCart,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppStrings.pacifico,
                      onPressed: () {
                        /// To Do o o o o o o o
                        BlocProvider.of<ProductDetailsCubit>(context)
                            .addToCart(uId: 'uId');
                        BlocProvider.of<ManageCartProductsCubit>(context)
                            .needToReGet();
                      },
                      width: context.width * 0.9,
                      height: context.height * 0.07,
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
}
/*
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
    ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: AppColors.primaryColorYellow,
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
              fontFamily: AppStrings.pacifico,
            ),
          ),
        ],
      ),
    );
  }
}*/

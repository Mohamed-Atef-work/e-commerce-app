import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';

class AdminDetailsScreen extends StatelessWidget {
  const AdminDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.productDetails),
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
                        fit: BoxFit.fill,
                        state.product!.image,
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
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                    fontFamily: AppStrings.pacifico,
                    text: "\$${state.product!.price * state.quantity}",
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
                      text: AppStrings.edit,
                      fontWeight: FontWeight.bold,
                      width: context.width * 0.9,
                      height: context.height * 0.07,
                      fontFamily: AppStrings.pacifico,
                      onPressed: () {
                        /// To Do o o o o o o o
                        Navigator.pushNamed(context, Screens.addProductScreen);
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

/*  @override
  Widget build(BuildContext context) {
    ///
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final ProductEntity product =
        ModalRoute.of(context)?.settings.arguments as ProductEntity;
    print(product.id);

    ///
    return BlocProvider<AdminProductDetailsCubit>(
      create: (context) => sl<AdminProductDetailsCubit>()
        ..emitProduct(product)
        ..loadProducts(product.category),
      child: Builder(builder: (context) {
        ///
        final controller = BlocProvider.of<AdminProductDetailsCubit>(context);

        ///
        return Scaffold(
          backgroundColor: AppColors.primaryColorYellow,
          appBar: appBar(
            title: AppStrings.productDetails,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            physics: const BouncingScrollPhysics(),
            children: [
              BlocBuilder<AdminProductDetailsCubit, AdminProductDetailsState>(
                buildWhen: (previous, current) =>
                    previous.selectedProduct != current.selectedProduct,
                builder: (context, state) {
                  return SizedBox(
                    width: width,
                    height: height / 2.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: width / 1.3,
                              height: height / 2.3,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: state.selectedProduct?.image == null
                                  ? Image.asset(
                                      "assets/images/icons/login_buy_icon.png",
                                      fit: BoxFit.cover,
                                      height: height / 4,
                                    )
                                  : Image.network(
                                      state.selectedProduct!.image,
                                      fit: BoxFit.fill,
                                      height: height / 4,
                                    ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Screens.addProductScreen,
                                      arguments: {"product": product},
                                    );
                                  },
                                  child: const Icon(Icons.edit,
                                      color: Colors.green),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AdminProductDetailsCubit>(
                                            context)
                                        .deleteProduct(
                                      DeleteProductParameters(
                                        product.id!,
                                        product.category,
                                      ),
                                    );
                                  },
                                  child: const CustomText(
                                    text: AppStrings.delete,
                                    textColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.01),
              CustomText(
                fontSize: 23,
                text: controller.state.selectedProduct!.category,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: height * 0.01),
              const AdminProductsWidget(),
              CustomButton(
                onPressed: () {
                  /// Navigate To Details
                  /// Make Admin Details Screen;
                  //Navigator.pushNamed(context, Screens.detailsScreen, arguments: product);
                },
                width: 0,
                height: 45,
                text: AppStrings.productDetails,
              ),
            ],
          ),
        );
      }),
    );
  }*/
}

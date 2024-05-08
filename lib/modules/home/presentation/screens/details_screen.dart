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
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
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
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: _listener,
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
                      child: Hero(
                        tag: state.product!.id!,
                        child: Image.network(
                          fit: BoxFit.fill,
                          state.product!.image,
                          width: double.infinity,
                          height: double.infinity,
                        ),
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

  void _listener(BuildContext context, ProductDetailsState state) {
    if (state.addToCart == RequestState.success) {
      showMyToast(AppStrings.added, Colors.green);
    } else if (state.addToCart == RequestState.error) {
      showMyToast(state.message!, Colors.red);
    }
  }
}

_appBar(BuildContext context) => appBar(
      title: AppStrings.details,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          BlocProvider.of<ProductDetailsCubit>(context).reset();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );

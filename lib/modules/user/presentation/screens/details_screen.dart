import 'package:e_commerce_app/core/utils/images.dart';
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
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = BlocProvider.of<ProductDetailsCubit>(context);
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final uId = userData.sharedEntity!.user.userEntity.id;

    final width = context.width;
    final height = context.height;

    return Scaffold(
      backgroundColor: kPrimaryColorYellow,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: Hero(
                      tag: state.product!.id!,
                      child: Container(
                        width: width * 0.9,
                        height: height * 0.45,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(state.product!.image),
                          placeholder: Svg(Images.loading),
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
                    fontFamily: kPacifico,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    text: "\$${state.product!.price * state.quantity}",
                  ),
                  CustomText(
                    maxLines: 5,
                    fontSize: 18,
                    textColor: kDarkBrown,
                    overflow: TextOverflow.ellipsis,
                    text: state.product!.description,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountingWidget(
                        width: width * 0.8,
                        num: state.quantity,
                        height: height * 0.05,
                        plus: () => detailsController.quantityPlus(),
                        minus: () => detailsController.quantityMinus(),
                      ),
                      HeartWihMangeFavoriteCubitProviderWidget(
                        heartColor: Colors.white,
                        product: state.product!,
                        iconsSize: 35,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      fontSize: 18,
                      width: width * 0.9,
                      fontFamily: kPacifico,
                      height: height * 0.07,
                      text: AppStrings.addToCart,
                      fontWeight: FontWeight.bold,
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
      showMyToast(AppStrings.added, context, Colors.green,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 80));
    } else if (state.addToCart == RequestState.error) {
      showMyToast(state.message!, context, Colors.red,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 80));
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

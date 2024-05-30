import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_state.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AdminDetailsScreen extends StatelessWidget {
  const AdminDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final controller = BlocProvider.of<AdminDetailsCubit>(context);
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<AdminDetailsCubit, AdminDetailsState>(
          builder: (_, state) {
            if (state.deleteState == RequestState.loading ||
                state.getState == RequestState.loading) {
              return const LoadingWidget();
            } else if (state.deleteState == RequestState.error ||
                state.getState == RequestState.error) {
              return MessengerComponent(state.message!);
            } else if (state.deleteState == RequestState.success) {
              return const MessengerComponent(AppStrings.deleted);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.center,
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
                    text: "\$${state.product!.price}",
                  ),
                  CustomText(
                    maxLines: 5,
                    fontSize: 18,
                    textColor: kDarkBrown,
                    overflow: TextOverflow.ellipsis,
                    text: state.product!.description,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          fixedSize: Size(width * 0.7, height * 0.06),
                          side: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: CustomText(
                          fontSize: 18,
                          fontFamily: kPacifico,
                          text: AppStrings.delete,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.red.withOpacity(0.8),
                        ),
                        onPressed: () => controller.deleteProduct(),
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
                      height: height * 0.07,
                      text: AppStrings.edit,
                      fontFamily: kPacifico,
                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        /// To Do o o o o o o o
                        Navigator.pushNamed(
                          context,
                          Screens.editProductScreen,
                          arguments: state.product!,
                        );
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

  _appBar(BuildContext context) => appBar(
        title: AppStrings.productDetails,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<AdminDetailsCubit>(context).reset();
            //BlocProvider.of<AdminDetailsCubit>(context).product(product);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      );
}

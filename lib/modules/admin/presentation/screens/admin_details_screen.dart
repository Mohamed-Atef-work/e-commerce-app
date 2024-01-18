import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';

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
        child: BlocBuilder<AdminDetailsCubit, AdminDetailsState>(
          builder: (context, state) {
            if (state.deleteState == RequestState.loading) {
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
                    text: "\$${state.product!.price}",
                  ),
                  SizedBox(height: context.height * 0.03),
                  CustomText(
                    fontSize: 18,
                    text: state.product!.description,
                    textColor: AppColors.darkBrown,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize:
                              Size(context.width * 0.7, context.height * 0.06),
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(
                              color: Colors.white, style: BorderStyle.solid),
                        ),
                        onPressed: () {
                          BlocProvider.of<AdminDetailsCubit>(context)
                              .deleteProduct();
                        },
                        child: const CustomText(
                          fontSize: 18,
                          textColor: Colors.red,
                          text: AppStrings.delete,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppStrings.pacifico,
                        ),
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
}

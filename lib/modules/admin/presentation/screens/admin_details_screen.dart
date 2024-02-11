import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_state.dart';

class AdminDetailsScreen extends StatelessWidget {
  const AdminDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: AppStrings.productDetails,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<AdminDetailsCubit>(context).reset();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: BlocBuilder<AdminDetailsCubit, AdminDetailsState>(
          buildWhen: (current, previous) =>
              current.deleteState != previous.deleteState,
          builder: (context, state) {
            if (state.deleteState == RequestState.loading) {
              return const LoadingWidget();
            } else if (state.deleteState == RequestState.success) {
              return const Center(
                child: CustomText(
                  fontSize: 25,
                  text: AppStrings.deleted,
                  fontWeight: FontWeight.bold,
                  fontFamily: kPacifico,
                ),
              );
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
                    fontFamily: kPacifico,
                  ),
                  CustomText(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.darkBrown,
                    fontFamily: kPacifico,
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
                        child: CustomText(
                          fontSize: 18,
                          text: AppStrings.delete,
                          fontWeight: FontWeight.bold,
                          fontFamily: kPacifico,
                          textColor: Colors.red.withOpacity(0.8),
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
                      fontFamily: kPacifico,
                      onPressed: () {
                        /// To Do o o o o o o o
                        Navigator.pushNamed(context, Screens.addProductScreen,
                            arguments: {"product": state.product!});
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

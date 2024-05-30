import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_state.dart';

class AddProductButtons extends StatelessWidget {
  const AddProductButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final controller = BlocProvider.of<AddProductCubit>(context);
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (_, state) {
        return state.productState == RequestState.loading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                child: const LoadingWidget(),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: width * 0.2,
                  right: width * 0.2,
                  top: height * 0.03,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      width: width * 0.5,
                      text: AppStrings.add,
                      height: height * 0.06,
                      onPressed: () => controller.addProduct(),
                    ),
                    SizedBox(height: height * 0.02),
                    GestureDetector(
                      onTap: () => controller.getImageFromGallery(),
                      child: CustomText(
                        fontSize: 15,
                        textAlign: TextAlign.center,
                        text: state.thereIsImage
                            ? AppStrings.changeTheImage
                            : AppStrings.addAnImage,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class EditProductButtons extends StatelessWidget {
  const EditProductButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final EditProductCubit controller =
        BlocProvider.of<EditProductCubit>(context);
    return BlocBuilder<EditProductCubit, EditProductState>(
      builder: (_, state) {
        return state.productState == RequestState.loading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                child: const LoadingWidget(),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: width * 0.2,
                  right: width * 0.2,
                  top: height * 0.03,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      width: width * 0.5,
                      height: height * 0.06,
                      text: AppStrings.update,
                      onPressed: () => controller.update(),
                    ),
                    SizedBox(height: height * 0.02),
                    GestureDetector(
                      onTap: () => controller.getImageFromGallery(),
                      child: const CustomText(
                        fontSize: 15,
                        textAlign: TextAlign.center,
                        text: AppStrings.changeTheImage,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

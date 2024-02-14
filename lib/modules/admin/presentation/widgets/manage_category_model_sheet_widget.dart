import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator/sl.dart';

class AddNewCategoryModelSheetWidget extends StatelessWidget {
  const AddNewCategoryModelSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesModelSheetCubit>(),
      child: Container(
        color: kPrimaryColorYellow,
        height: context.height * 0.4,
        child: Builder(builder: (context) {
          final controller =
              BlocProvider.of<CategoriesModelSheetCubit>(context);
          return BlocBuilder<CategoriesModelSheetCubit,
              CategoriesModelSheetState>(
            builder: (context, state) {
              if (state.addCategoryState == RequestState.loading) {
                return const LoadingWidget();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.02,
                    horizontal: context.width * 0.01,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(

                          hintText: AppStrings.newCategory,
                          fontSize: 15,
                          textEditingController: controller.categoryController,
                          validator: (value) => Validators.stringValidator(
                              value, AppStrings.category),
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),
                        CustomButton(
                          onPressed: () {
                            controller.addNewCategory();
                          },
                          width: context.width * 0.3,
                          height: context.height * 0.065,
                          text: AppStrings.add,
                          backgroundColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}

class DeleteUpdateCategoryModelSheetWidget extends StatelessWidget {
  final ProductCategoryEntity category;
  const DeleteUpdateCategoryModelSheetWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CategoriesModelSheetCubit>()..takeCategoryName(category.name),
      child: Container(
          color: kPrimaryColorYellow,
          height: context.height * 0.4,
          child: Builder(builder: (context) {
            final controller =
                BlocProvider.of<CategoriesModelSheetCubit>(context);
            return BlocBuilder<CategoriesModelSheetCubit,
                CategoriesModelSheetState>(builder: (context, state) {
              if (state.updateCategoryState == RequestState.loading ||
                  state.deleteCategoryState == RequestState.loading) {
                return const LoadingWidget();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.02,
                    horizontal: context.width * 0.01,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          fontSize: 15,
                          hintText: AppStrings.category,

                          textEditingController: controller.categoryController,
                          validator: (value) => Validators.stringValidator(
                              value, AppStrings.category),
                        ),
                        SizedBox(
                          height: context.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              onPressed: () {
                                controller.updateCategory(
                                    UpDateProductsCategoryParameters(
                                        name:
                                            controller.categoryController.text,
                                        id: category.id));
                              },
                              width: context.width * 0.3,
                              height: context.height * 0.065,
                              text: AppStrings.update,
                              backgroundColor: Colors.black,
                            ),
                            CustomButton(
                              onPressed: () {
                                controller.deleteCategory(
                                    DeleteProductsCategoryParameters(name: category.name,
                                        id: category.id,));
                              },
                              width: context.width * 0.3,
                              height: context.height * 0.065,
                              text: AppStrings.delete,
                              backgroundColor: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            });
          })),
    );
  }
}

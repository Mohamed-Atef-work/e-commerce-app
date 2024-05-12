import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator/sl.dart';

class DeleteUpdateCategoryModelSheetWidget extends StatelessWidget {
  final ProductCategoryEntity category;
  const DeleteUpdateCategoryModelSheetWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CategoriesModelSheetCubit>()..takeCategoryName(category.name),
      child: BaseModelSheetComponent(
        height: context.height * 0.4,
        child: Builder(
          builder: (context) {
            final controller =
                BlocProvider.of<CategoriesModelSheetCubit>(context);
            return BlocBuilder<CategoriesModelSheetCubit,
                CategoriesModelSheetState>(
              builder: (context, state) {
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
                            validator: _categoryValidator,
                            textEditingController:
                                controller.categoryController,
                          ),
                          SizedBox(height: context.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  controller.updateCategory(
                                    UpDateProductsCategoryParams(
                                      name: controller.categoryController.text,
                                      id: category.id,
                                    ),
                                  );
                                },
                                text: AppStrings.update,
                                width: context.width * 0.3,
                                backgroundColor: Colors.black,
                                height: context.height * 0.065,
                              ),
                              CustomButton(
                                onPressed: () {
                                  controller.deleteCategory(
                                    DeleteProductsCategoryParams(
                                      name: category.name,
                                      id: category.id,
                                    ),
                                  );
                                },
                                text: AppStrings.delete,
                                width: context.width * 0.3,
                                backgroundColor: Colors.black,
                                height: context.height * 0.065,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  String? _categoryValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.category);
}

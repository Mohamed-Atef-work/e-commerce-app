import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/config/routes/pages.dart';

class DeleteUpdateCategoryModelSheetWidget extends StatelessWidget {
  final ProductCategoryEntity category;
  const DeleteUpdateCategoryModelSheetWidget(
      {super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CategoriesModelSheetCubit>()..takeCategoryName(category.name),
      child: BaseModelSheetComponent(
        child: Builder(
          builder: (context) {
            final controller =
                BlocProvider.of<CategoriesModelSheetCubit>(context);
            return BlocBuilder<CategoriesModelSheetCubit,
                CategoriesModelSheetState>(
              builder: (context, state) {
                if (state.categoryState == RequestState.loading) {
                  return const LoadingWidget();
                } else if (state.categoryState == RequestState.error) {
                  return MessengerComponent(state.message!);
                } else if (state.categoryState == RequestState.success) {
                  return const MessengerComponent(AppStrings.done);
                } else {
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.height * 0.01),
                          child: CustomTextFormField(
                            fontSize: 15,
                            hintText: AppStrings.category,
                            validator: _categoryValidator,
                            textEditingController:
                                controller.categoryController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              onPressed: () {
                                final params = UpDateProductsCategoryParams(
                                  newName: controller.categoryController.text,
                                  oldName: category.name,
                                  id: category.id,
                                );
                                controller.updateCategory(params);
                              },
                              text: AppStrings.update,
                              backgroundColor: Colors.black,
                              height: context.height * 0.065,
                            ),
                            CustomButton(
                              onPressed: () {
                                final params = DeleteProductsCategoryParams(
                                  name: category.name,
                                  id: category.id,
                                );
                                controller.deleteCategory(params);
                              },
                              text: AppStrings.delete,
                              //width: context.width * 0.3,
                              backgroundColor: Colors.black,
                              height: context.height * 0.065,
                            ),
                          ],
                        ),
                      ],
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

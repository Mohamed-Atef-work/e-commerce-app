import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator/sl.dart';

class AddNewCategoryModelSheetWidget extends StatelessWidget {
  const AddNewCategoryModelSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesModelSheetCubit>(),
      child: BaseModelSheetComponent(
        height: context.height * 0.4,
        child: Builder(
          builder: (context) {
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
                            fontSize: 15,
                            validator: _categoryValidator,
                            hintText: AppStrings.newCategory,
                            textEditingController:
                                controller.categoryController,
                          ),
                          SizedBox(height: context.height * 0.03),
                          CustomButton(
                            onPressed: () {
                              controller.addNewCategory();
                            },
                            text: AppStrings.add,
                            width: context.width * 0.3,
                            backgroundColor: Colors.black,
                            height: context.height * 0.065,
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

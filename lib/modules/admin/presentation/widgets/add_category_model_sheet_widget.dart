import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/categories_model_sheet_controller_in_edit_add_screen/categories_model_sheet_state.dart';
import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

import 'package:flutter/material.dart';

class AddNewCategoryModelSheetWidget extends StatelessWidget {
  const AddNewCategoryModelSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesModelSheetCubit>(),
      child: BaseModelSheetComponent(
        child: Builder(
          builder: (context) {
            final controller =
                BlocProvider.of<CategoriesModelSheetCubit>(context);
            return BlocBuilder<CategoriesModelSheetCubit,
                CategoriesModelSheetState>(
              builder: (context, state) {
                if (state.addCategoryState == RequestState.loading) {
                  return const LoadingWidget();
                } else if (state.addCategoryState == RequestState.success) {
                  return const MessengerComponent(AppStrings.added);
                } else if (state.addCategoryState == RequestState.error) {
                  return MessengerComponent(state.message!);
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
                            validator: _categoryValidator,
                            hintText: AppStrings.newCategory,
                            textEditingController:
                                controller.categoryController,
                          ),
                        ),
                        CustomButton(
                          text: AppStrings.add,
                          width: context.width * 0.3,
                          backgroundColor: Colors.black,
                          height: context.height * 0.06,
                          onPressed: () => controller.addNewCategory(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import '../../../../core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import '../../../../core/components/custom_text_form_field.dart';
import '../controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/product_categories_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_cubit.dart';

class AddProductFormWidget extends StatelessWidget {
  const AddProductFormWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final controller = BlocProvider.of<AddProductCubit>(context);

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const AdminCategoriesWidgetOfAddProduct(),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            validator: _nameValidator,
            hintText: AppStrings.productName,
            textEditingController: controller.nameController,
          ),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            validator: _priceValidator,
            hintText: AppStrings.productPrice,
            textEditingController: controller.priceController,
          ),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            maxLines: null,
            validator: _descriptionValidator,
            hintText: AppStrings.productDescription,
            textEditingController: controller.descriptionController,
          ),
        ],
      ),
    );
  }
}

class EditProductFormWidget extends StatelessWidget {
  const EditProductFormWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final controller = BlocProvider.of<EditProductCubit>(context);

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const AdminCategoriesWidgetOfEditProduct(),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            validator: _nameValidator,
            hintText: AppStrings.productName,
            textEditingController: controller.nameController,
          ),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            validator: _priceValidator,
            hintText: AppStrings.productPrice,
            textEditingController: controller.priceController,
          ),
          SizedBox(height: height * 0.01),
          CustomTextFormField(
            fontSize: 18,
            maxLines: null,
            validator: _descriptionValidator,
            hintText: AppStrings.productDescription,
            textEditingController: controller.descriptionController,
          ),
        ],
      ),
    );
  }
}

String? _nameValidator(String? value) =>
    Validators.stringValidator(value, AppStrings.productName);

String? _locationValidator(String? value) =>
    Validators.stringValidator(value, AppStrings.productLocation);

String? _descriptionValidator(String? value) =>
    Validators.descriptionValidator(value);

String? _priceValidator(String? value) =>
    Validators.numericValidator(value, AppStrings.productPrice);

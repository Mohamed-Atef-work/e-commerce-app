import 'package:e_commerce_app/modules/admin/presentation/widgets/product_categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import '../../../../core/components/custom_text_form_field.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../controllers/add_product_controller/add_product_cubit.dart';

class AddProductFormWidget extends StatelessWidget {
  const AddProductFormWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final EditAddProductCubit controller =
        BlocProvider.of<EditAddProductCubit>(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const ProductCategoriesWidget(),
          SizedBox(
            height: height * 0.01,
          ),
          CustomTextFormField(
            textEditingController: controller.nameController,
            onChanged: (value) {
              //controller.productName = value!;
            },
            validator: (value) => Validators.stringValidator(
              value,
              AppStrings.productName,
            ),
            fillColor: AppColors.loginTextFormFieldGray,
            hintText: AppStrings.productName,
            fontSize: 18,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          CustomTextFormField(
            textEditingController: controller.priceController,
            onChanged: (value) {
              //controller.productPrice = value!;
            },
            validator: (value) => Validators.numericValidator(
              value,
              AppStrings.productPrice,
            ),
            fillColor: AppColors.loginTextFormFieldGray,
            hintText: AppStrings.productPrice,
            fontSize: 18,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          CustomTextFormField(
            textEditingController: controller.descriptionController,
            onChanged: (value) {
              //controller.productDescription = value!;
            },
            validator: (value) => Validators.stringValidator(
              value,
              AppStrings.productDescription,
            ),
            fillColor: AppColors.loginTextFormFieldGray,
            hintText: AppStrings.productDescription,
            fontSize: 18,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          CustomTextFormField(
            textEditingController: controller.locationController,
            onChanged: (value) {
              //controller.productLocation = value!;
            },
            validator: (value) => Validators.stringValidator(
              value,
              AppStrings.productLocation,
            ),
            fillColor: AppColors.loginTextFormFieldGray,
            hintText: AppStrings.productLocation,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';
import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UpDateOrderDataWidget extends StatelessWidget {
  const UpDateOrderDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.height * 0.01;
    final controller = BlocProvider.of<UpdateOrderDataCubit>(context);
    return BaseModelSheetComponent(
      child: BlocBuilder<UpdateOrderDataCubit, UpdateOrderDataState>(
        builder: (_, state) {
          if (state.updateState == RequestState.loading) {
            return const LoadingWidget();
          } else if (state.updateState == RequestState.success) {
            return const MessengerComponent(AppStrings.updated);
          } else {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(height: padding),
                  CustomTextFormField(
                    fontSize: 15,
                    prefixIcon: Icons.person,
                    hintText: AppStrings.name,
                    validator: _nameValidator,
                    textEditingController: controller.name,
                  ),
                  SizedBox(height: padding),
                  CustomTextFormField(
                    fontSize: 15,
                    hintText: AppStrings.phone,
                    validator: _phoneValidator,
                    prefixIcon: Icons.phone_android,
                    textEditingController: controller.phone,
                  ),
                  SizedBox(height: padding),
                  CustomTextFormField(
                    fontSize: 15,
                    prefixIcon: Icons.place,
                    hintText: AppStrings.address,
                    validator: _addressValidator,
                    textEditingController: controller.address,
                  ),
                  SizedBox(height: padding),
                  CustomButton(
                    height: 50,
                    fontSize: 18,
                    fontFamily: kPacifico,
                    text: AppStrings.update,
                    width: context.width * 0.7,
                    onPressed: () => controller.updateOrderData(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String? _addressValidator(String? value) =>
      Validators.addressValidator(value, AppStrings.address);

  String? _nameValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.name);

  String? _phoneValidator(String? value) =>
      Validators.numericValidator(value, AppStrings.phone);
}

import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/constants.dart';

class UpDateOrderDataWidget extends StatelessWidget {
  const UpDateOrderDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseModelSheetComponent(
      height: context.height * 0.5,
      child: BlocBuilder<UpdateOrderDataCubit, UpdateOrderDataState>(
        builder: (context, state) {
          if (state.updateState == RequestState.loading) {
            return const LoadingWidget();
          } else if (state.updateState == RequestState.success) {
            return MessengerComponent(
              AppStrings.updated,
              imageWidth: context.height * 0.3,
              imageHeight: context.height * 0.2,
            );
          } else {
            return Form(
              key: BlocProvider.of<UpdateOrderDataCubit>(context).formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    fontSize: 15,
                    hintText: AppStrings.name,
                    prefixIcon: Icons.person,
                    textEditingController:
                        BlocProvider.of<UpdateOrderDataCubit>(context).name,
                    validator: (value) =>
                        Validators.stringValidator(value, AppStrings.name),
                  ),
                  CustomTextFormField(
                    fontSize: 15,
                    hintText: AppStrings.phone,
                    prefixIcon: Icons.phone_android,
                    textEditingController:
                        BlocProvider.of<UpdateOrderDataCubit>(context).phone,
                    validator: (value) =>
                        Validators.numericValidator(value, AppStrings.phone),
                  ),
                  CustomTextFormField(
                    fontSize: 15,
                    prefixIcon: Icons.place,
                    hintText: AppStrings.address,
                    textEditingController:
                        BlocProvider.of<UpdateOrderDataCubit>(context).address,
                    validator: (value) =>
                        Validators.addressValidator(value, AppStrings.address),
                  ),
                  CustomButton(
                    height: 50,
                    fontSize: 18,
                    onPressed: () {
                      BlocProvider.of<UpdateOrderDataCubit>(context)
                          .updateOrderData();
                    },
                    text: AppStrings.update,
                    width: context.width * 0.7,
                    fontFamily: kPacifico,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

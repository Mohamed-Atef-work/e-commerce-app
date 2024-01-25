import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/modules/orders/presentation/controller/update_order_data_controller/update_order_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpDateOrderDataWidget extends StatelessWidget {
  const UpDateOrderDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.6,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.white,
          style: BorderStyle.solid,
        ),
        color: AppColors.primaryColorYellow,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: BlocBuilder<UpdateOrderDataCubit, UpdateOrderDataState>(
        builder: (context, state) {
          if (state.updateState == RequestState.loading) {
            return const LoadingWidget();
          } else if (state.updateState == RequestState.success) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    fontSize: 25,
                    text: AppStrings.updated,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppStrings.pacifico,
                  ),
                  SizedBox(
                    height: context.height * 0.03
                  ),
                  CustomButton(
                    onPressed: () {},
                    text: AppStrings.ok,
                    fontFamily: AppStrings.pacifico,
                    width: context.height * 0.1,
                    height: context.height * 0.05,
                  ),
                ],
              ),
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
                    fillColor: AppColors.loginTextFormFieldGray,
                  ),
                  CustomTextFormField(
                    fontSize: 15,
                    hintText: AppStrings.phone,
                    prefixIcon: Icons.phone_android,
                    textEditingController:
                        BlocProvider.of<UpdateOrderDataCubit>(context).phone,
                    validator: (value) =>
                        Validators.numericValidator(value, AppStrings.phone),
                    fillColor: AppColors.loginTextFormFieldGray,
                  ),
                  CustomTextFormField(
                    fontSize: 15,
                    prefixIcon: Icons.place,
                    hintText: AppStrings.address,
                    textEditingController:
                        BlocProvider.of<UpdateOrderDataCubit>(context).address,
                    validator: (value) =>
                        Validators.stringValidator(value, AppStrings.address),
                    fillColor: AppColors.loginTextFormFieldGray,
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
                    fontFamily: AppStrings.pacifico,
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

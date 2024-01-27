import 'package:e_commerce_app/modules/shared/presentation/controller/address_controller/edit_address_cubit.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.changePassword),
      body: BlocProvider(
        create: (context) => sl<EditAddressCubit>(),
        child: Form(
          key: BlocProvider.of<EditAddressCubit>(context).formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextFormField(
                fontSize: 15,
                prefixIcon: Icons.lock,
                fillColor: AppColors.whiteGray,
                hintText: AppStrings.oldPassword,
                textEditingController:
                    BlocProvider.of<EditAddressCubit>(context).city,
                validator: (value) => Validators.passwordValidator(value),
              ),
              SizedBox(height: context.height * 0.01),
              CustomTextFormField(
                fontSize: 15,
                prefixIcon: Icons.lock,
                fillColor: AppColors.whiteGray,
                hintText: AppStrings.newPassword,
                textEditingController:
                    BlocProvider.of<EditAddressCubit>(context).street,
                validator: (value) => Validators.passwordValidator(value),
              ),
              SizedBox(height: context.height * 0.01),
              CustomTextFormField(
                fontSize: 15,
                prefixIcon: Icons.lock,
                fillColor: AppColors.whiteGray,
                hintText: AppStrings.confirmPassword,
                textEditingController:
                    BlocProvider.of<EditAddressCubit>(context).apartment,
                validator: (value) => Validators.passwordValidator(value),
              ),
              SizedBox(height: context.height * 0.01),
              BlocBuilder<EditAddressCubit, EditAddressState>(
                builder: (context, state) {
                  if (state.changeState == RequestState.loading) {
                    return const LoadingWidget();
                  } else {
                    return CustomButton(
                      height: 50,
                      fontSize: 18,
                      onPressed: () {},
                      text: AppStrings.update,
                      width: context.width * 0.7,
                      fontFamily: AppStrings.pacifico,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

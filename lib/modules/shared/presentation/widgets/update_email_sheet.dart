import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/change_email_controller/change_email_cubit.dart';

class UpDateEmailWidget extends StatelessWidget {
  const UpDateEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangeEmailCubit>(),
      child: Builder(builder: (context) {
        /// bloc
        final updateEmailController =
            BlocProvider.of<ChangeEmailCubit>(context);
        final userDataController =
            BlocProvider.of<SharedUserDataCubit>(context);
        final userData = userDataController.state.sharedEntity!.user;

        /// bloc
        return BaseModelSheetComponent(
          height: context.height * 0.5,
          child: BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
            listener: (_, state) {
              if (state.changeState == RequestState.success) {
                userDataController.getSavedUser();
              }
            },
            builder: (_, state) {
              if (state.changeState == RequestState.loading) {
                return const LoadingWidget();
              } else if (state.changeState == RequestState.success) {
                return MessengerComponent(
                  AppStrings.updated,
                  imageWidth: context.height * 0.2,
                  imageHeight: context.height * 0.1,
                );
              } else {
                return Form(
                  key: updateEmailController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        prefixIcon: Icons.email,
                        hintText: AppStrings.oldEmail,
                        textEditingController: updateEmailController.oldEmail,
                        validator: (value) => Validators.emailValidator(value),
                      ),
                      CustomTextFormField(
                        prefixIcon: Icons.email,
                        hintText: AppStrings.newEmail,
                        textEditingController: updateEmailController.newEmail,
                        validator: (value) => Validators.emailValidator(value),
                      ),
                      PasswordTextFormField(
                        obSecure: state.obSecure,
                        hintText: AppStrings.enterYourPassword,
                        textEditingController: updateEmailController.password,
                        suffixPressed: () => updateEmailController.obSecure(),
                      ),
                      CustomButton(
                        height: 50,
                        fontSize: 18,
                        fontFamily: kPacifico,
                        text: AppStrings.update,
                        width: context.width * 0.7,
                        onPressed: () =>
                            _onPressed(updateEmailController, userData),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  _onPressed(emailController, data) {
    /// upDate.........................................

    final userEntity = UserEntity(
      id: data.userEntity.id,
      name: data.userEntity.name,
      phone: data.userEntity.phone,
      address: data.userEntity.address,
      email: emailController.newEmail.text,
    );
    final cachedUser = CachedUserDataEntity(
      userEntity: userEntity,
      password: data.password,
      adminOrUser: data.adminOrUser,
    );

    if (emailController.newEmail.text != emailController.oldEmail.text &&
        emailController.oldEmail.text == data.userEntity.email) {
      emailController.changeEmail(cachedUser);
    }
  }
}

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
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/core/components/base_model_sheet_component.dart';
import 'package:e_commerce_app/core/components/centered_message_component.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/up_date_profile_controller/update_profile_cubit.dart';

class UpDatePhoneWidget extends StatelessWidget {
  const UpDatePhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// bloc
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);
    final userData = userDataController.state.sharedEntity!.user;

    /// bloc
    return BlocProvider(
      create: (context) => sl<UpdateProfileCubit>(),
      child: Builder(builder: (context) {
        /// bloc
        final updateProfileController =
            BlocProvider.of<UpdateProfileCubit>(context);

        /// bloc
        return BaseModelSheetComponent(
          height: context.height * 0.3,
          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state.updateState == RequestState.success) {
                userDataController.getSavedUser();
              }
            },
            builder: (context, state) {
              if (state.updateState == RequestState.loading) {
                return const LoadingWidget();
              } else if (state.updateState == RequestState.success) {
                return const CenteredMessageComponent(AppStrings.updated);
              } else {
                return Form(
                  key: updateProfileController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        hintText: AppStrings.phone,
                        prefixIcon: Icons.phone_android,
                        textEditingController:
                            updateProfileController.changedOne,
                        validator: (value) => Validators.numericValidator(
                            value, AppStrings.phone),
                      ),
                      CustomButton(
                        height: 50,
                        fontSize: 18,
                        fontFamily: kPacifico,
                        text: AppStrings.update,
                        width: context.width * 0.7,
                        onPressed: () {
                          final userEntity = UserEntity(
                            id: userData.userEntity.id,
                            name: userData.userEntity.name,
                            email: userData.userEntity.email,
                            address: userData.userEntity.address,
                            phone: updateProfileController.changedOne.text,
                          );
                          final cachedUser = CachedUserDataEntity(
                            userEntity: userEntity,
                            password: userData.password,
                            adminOrUser: userData.adminOrUser,
                          );
                          updateProfileController.updateName(cachedUser);
                        },
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
}

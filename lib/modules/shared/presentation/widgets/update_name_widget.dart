import 'package:e_commerce_app/core/components/messenger_component.dart';
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
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/up_date_profile_controller/update_profile_cubit.dart';

class UpDateNameWidget extends StatelessWidget {
  const UpDateNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// bloc
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);
    final userData = userDataController.state.sharedEntity!.user;

    /// bloc
    return BlocProvider(
      create: (_) => sl<UpdateProfileCubit>(),
      child: BaseModelSheetComponent(
        height: context.height * 0.3,
        child: Builder(builder: (context) {
          /// bloc
          final updateProfileController =
              BlocProvider.of<UpdateProfileCubit>(context);

          /// bloc
          return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (_, state) {
              if (state.updateState == RequestState.success) {
                userDataController.getSavedUser();
              }
            },
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
                  key: updateProfileController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        prefixIcon: Icons.person,
                        hintText: AppStrings.name,
                        textEditingController:
                            updateProfileController.changedOne,
                        validator: (value) =>
                            Validators.stringValidator(value, AppStrings.name),
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
                            email: userData.userEntity.email,
                            phone: userData.userEntity.phone,
                            address: userData.userEntity.address,
                            name: updateProfileController.changedOne.text,
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
          );
        }),
      ),
    );
  }
}

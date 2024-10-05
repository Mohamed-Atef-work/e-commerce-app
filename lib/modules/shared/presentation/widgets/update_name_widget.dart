import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
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
    return BlocProvider(
      create: (_) => sl<UpdateProfileCubit>(),
      child: BaseModelSheetComponent(
        child: Builder(
          builder: (context) {
            /// bloc
            final updateProfileController =
                BlocProvider.of<UpdateProfileCubit>(context);
            final dataController =
                BlocProvider.of<SharedUserDataCubit>(context);
            final userData = dataController.state.sharedEntity!.user;

            /// bloc
            return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
              listener: (_, state) => _listener(dataController, state),
              builder: (_, state) {
                if (state.updateState == RequestState.loading) {
                  return const LoadingWidget();
                } else if (state.updateState == RequestState.success) {
                  return const MessengerComponent(AppStrings.updated);
                } else {
                  return Form(
                    key: updateProfileController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: CustomTextFormField(
                            prefixIcon: Icons.person,
                            hintText: AppStrings.name,
                            validator: _nameValidator,
                            textEditingController:
                                updateProfileController.changedOne,
                          ),
                        ),
                        CustomButton(
                          height: 50,
                          fontSize: 18,
                          fontFamily: kPacifico,
                          text: AppStrings.update,
                          width: context.width * 0.7,
                          onPressed: () =>
                              _onPressed(updateProfileController, userData),
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

  _onPressed(UpdateProfileCubit controller, CachedUserDataEntity data) {
    final userEntity = UserEntity(
      id: data.userEntity.id,
      email: data.userEntity.email,
      phone: data.userEntity.phone,
      address: data.userEntity.address,
      name: controller.changedOne.text,
    );
    final cachedUser = CachedUserDataEntity(
      userEntity: userEntity,
      password: data.password,
      adminOrUser: data.adminOrUser,
    );
    controller.updateName(cachedUser);
  }

  _listener(SharedUserDataCubit controller, state) {
    if (state.updateState == RequestState.success) {
      controller.getSavedUser();
    }
  }

  String? _nameValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.name);
}

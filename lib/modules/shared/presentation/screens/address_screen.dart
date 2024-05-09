import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/address_controller/edit_address_cubit.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EditAddressCubit>(),
      child: Builder(
        builder: (context) {
          final addressController = BlocProvider.of<EditAddressCubit>(context);

          return Scaffold(
            appBar: appBar(title: AppStrings.address),
            body: Padding(
              padding: EdgeInsets.only(
                top: context.height * 0.1,
                left: 10,
                right: 10,
              ),
              child: Form(
                key: addressController.formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormField(
                      hintText: AppStrings.city,
                      validator: _cityValidator,
                      prefixIcon: Icons.location_on_outlined,
                      textEditingController: addressController.city,
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.add_road,
                      hintText: AppStrings.street,
                      validator: _streetValidator,
                      textEditingController: addressController.street,
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.apartment,
                      hintText: AppStrings.buildingBloc,
                      validator: _buildingBLocValidator,
                      textEditingController: addressController.bloc,
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.home,
                      hintText: AppStrings.apartment,
                      validator: _apartmentValidator,
                      textEditingController: addressController.apartment,
                    ),
                    _sizedBox(context.height * 0.02),
                    BlocConsumer<EditAddressCubit, EditAddressState>(
                      listener: (context, state) {
                        _listener(context, state);
                      },
                      builder: (context, state) {
                        if (state.changeState == RequestState.loading) {
                          return const LoadingWidget();
                        } else {
                          return CustomButton(
                            fontFamily: kPacifico,
                            text: AppStrings.update,
                            width: context.width * 0.7,
                            onPressed: () {
                              final shared = _data(context);
                              addressController.updateAddress(shared.user);
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _cityValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.city);

  String? _streetValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.street);

  String? _buildingBLocValidator(String? value) =>
      Validators.stringValidator(value, AppStrings.buildingBloc);

  String? _apartmentValidator(String? value) =>
      Validators.numericValidator(value, AppStrings.apartment);

  void _listener(BuildContext context, EditAddressState state) {
    if (state.changeState == RequestState.success) {
      final shared = _data(context);
      final userDataController = BlocProvider.of<SharedUserDataCubit>(context);
      userDataController.takeShared(shared);
      BlocProvider.of<EditAddressCubit>(context).clear();
      showMyToast(AppStrings.success, context, Colors.green);
    } else if (state.changeState == RequestState.error) {
      showMyToast(state.message, context, Colors.red);
    }
  }

  SharedUserDataEntity _data(BuildContext context) {
    final addressController = BlocProvider.of<EditAddressCubit>(context);
    final userDataController = BlocProvider.of<SharedUserDataCubit>(context);
    final userData = userDataController.state.sharedEntity;

    final cashed = CachedUserDataEntity(
      userEntity: UserEntity(
        address: "${addressController.city.text},"
            " ${addressController.street.text},"
            " ${addressController.bloc.text},"
            " ${addressController.apartment.text}",
        id: userData!.user.userEntity.id,
        name: userData.user.userEntity.name,
        email: userData.user.userEntity.email,
        phone: userData.user.userEntity.phone,
      ),
      password: userData.user.password,
      adminOrUser: userData.user.adminOrUser,
    );
    final shared = SharedUserDataEntity(
      user: cashed,
      userCredential: userData.userCredential,
    );

    return shared;
  }

  _sizedBox(double height) => SizedBox(height: height);
}

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
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/address_controller/edit_address_cubit.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EditAddressCubit>(),
      child: Builder(
        builder: (context) {
          final addressController = BlocProvider.of<EditAddressCubit>(context);
          final userDataController =
              BlocProvider.of<SharedUserDataCubit>(context);
          final user = UserModel(
            id: userDataController.state.sharedEntity!.user.userEntity.id,
            name: userDataController.state.sharedEntity!.user.userEntity.name,
            email: userDataController.state.sharedEntity!.user.userEntity.email,
            phone: userDataController.state.sharedEntity!.user.userEntity.phone,
          );
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
                      prefixIcon: Icons.location_on_outlined,
                      textEditingController: addressController.city,
                      validator: (value) =>
                          Validators.stringValidator(value, AppStrings.city),
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.add_road,
                      hintText: AppStrings.street,
                      textEditingController: addressController.street,
                      validator: (value) =>
                          Validators.stringValidator(value, AppStrings.street),
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.apartment,
                      hintText: AppStrings.buildingBloc,
                      textEditingController: addressController.bloc,
                      validator: (value) => Validators.stringValidator(
                          value, AppStrings.buildingBloc),
                    ),
                    _sizedBox(context.height * 0.02),
                    CustomTextFormField(
                      prefixIcon: Icons.home,
                      hintText: AppStrings.apartment,
                      textEditingController: addressController.apartment,
                      validator: (value) => Validators.numericValidator(
                          value, AppStrings.apartment),
                    ),
                    _sizedBox(context.height * 0.02),
                    MultiBlocListener(
                        listeners: [
                          BlocListener<SharedUserDataCubit,
                              SharedUserDataState>(listener: (context, state) {
                            print(
                                "save State is ---------> ${state.saveState}");
                          }),
                          BlocListener<EditAddressCubit, EditAddressState>(
                              listener: (context, state) {
                            print(
                                "address State is ---------> ${state.changeState}");

                            if (state.changeState == RequestState.success) {
                              userDataController.savePartOfUserDataLocally(
                                address: "${addressController.city.text},"
                                    " ${addressController.street.text},"
                                    " ${addressController.bloc.text},"
                                    " ${addressController.apartment.text}",
                              );
                            }
                          }),
                        ],
                        child: BlocBuilder<SharedUserDataCubit,
                            SharedUserDataState>(
                          builder: (context, state) {
                            if (state.saveState == RequestState.loading) {
                              return const LoadingWidget();
                            } else {
                              return BlocBuilder<EditAddressCubit,
                                  EditAddressState>(
                                builder: (context, state) {
                                  if (state.changeState ==
                                      RequestState.loading) {
                                    return const LoadingWidget();
                                  } else {
                                    return CustomButton(
                                      height: 50,
                                      fontSize: 18,
                                      fontFamily: kPacifico,
                                      text: AppStrings.update,
                                      width: context.width * 0.7,
                                      onPressed: () {
                                        addressController.updateAddress(user);
                                      },
                                    );
                                  }
                                },
                              );
                            }
                          },
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _sizedBox(double height) => SizedBox(height: height);
}

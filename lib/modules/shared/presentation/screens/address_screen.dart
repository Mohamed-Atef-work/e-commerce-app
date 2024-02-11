import 'package:e_commerce_app/modules/shared/presentation/controller/address_controller/edit_address_cubit.dart';
import 'package:e_commerce_app/core/components/custom_text_form_field.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/constants.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EditAddressCubit>(),
      child: Builder(builder: (context) {
        final controller = BlocProvider.of<EditAddressCubit>(context);
        return Scaffold(
          appBar: appBar(title: AppStrings.address),
          body: Padding(
            padding:
                EdgeInsets.only(top: context.height * 0.1, left: 10, right: 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.city,
                    prefixIcon: Icons.location_on_outlined,
                    textEditingController: controller.city,
                    validator: (value) =>
                        Validators.stringValidator(value, AppStrings.city),
                  ),
                  _sizedBox(context.height * 0.02),
                  CustomTextFormField(
                    prefixIcon: Icons.add_road,
                    hintText: AppStrings.street,
                    textEditingController: controller.street,
                    validator: (value) =>
                        Validators.stringValidator(value, AppStrings.street),
                  ),
                  _sizedBox(context.height * 0.02),
                  CustomTextFormField(
                    prefixIcon: Icons.apartment,
                    hintText: AppStrings.buildingBloc,
                    textEditingController: controller.bloc,
                    validator: (value) => Validators.stringValidator(
                        value, AppStrings.buildingBloc),
                  ),
                  _sizedBox(context.height * 0.02),
                  CustomTextFormField(
                    prefixIcon: Icons.home,
                    hintText: AppStrings.apartment,
                    textEditingController: controller.apartment,
                    validator: (value) => Validators.numericValidator(
                        value, AppStrings.apartment),
                  ),
                  _sizedBox(context.height * 0.02),
                  BlocBuilder<EditAddressCubit, EditAddressState>(
                    builder: (context, state) {
                      if (state.changeState == RequestState.loading) {
                        return const LoadingWidget();
                      } else {
                        return CustomButton(
                          height: 50,
                          fontSize: 18,
                          onPressed: () {
                            controller.updateAddress();
                          },
                          text: AppStrings.update,
                          width: context.width * 0.7,
                          fontFamily: kPacifico,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _sizedBox(double height) => SizedBox(height: height);
}

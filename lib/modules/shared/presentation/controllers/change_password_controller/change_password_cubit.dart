import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password_params.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepositoryDomain _authRepo;

  ChangePasswordCubit(this._authRepo) : super(const ChangePasswordState());

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void changePassword() async {
    print("canaegekadadgla;jkggggggggggggggggggggggggggggggggg");
    if (formKey.currentState!.validate()) {
      if (newPassword.text == confirmPassword.text &&
          confirmPassword.text != oldPassword.text) {
        emit(state.copyWith(changeState: RequestState.loading));
        final result = await _authRepo.updatePassword(
          UpdatePasswordParams(
              currentPassword: oldPassword.text, newPassword: newPassword.text),
        );
        emit(
          result.fold(
            (l) => state.copyWith(
                changeState: RequestState.error, message: l.message),
            (r) => state.copyWith(changeState: RequestState.success),
          ),
        );
        print("canaegekadadgla;jkggggggggggggggggggggggggggggggggg");
        print(state.changeState);

        if (result.isRight()) {
          oldPassword.text = "";
          newPassword.text = "";
          confirmPassword.text = "";
        }
      } else if (newPassword.text == oldPassword.text) {
        emit(
          state.copyWith(
            changeState: RequestState.error,
            message: AppStrings.newPasswordNotCorrect,
          ),
        );
      } else if (newPassword.text != confirmPassword.text) {
        emit(
          state.copyWith(
            changeState: RequestState.error,
            message: AppStrings.confirmPasswordNotCorrect,
          ),
        );
      }
    }
  }

  void obSecure({bool? oldPassword, newPassword, confirmPassword}) {
    emit(
      state.copyWith(
        newPassword: newPassword,
        oldPassword: oldPassword,
        confirmPassword: confirmPassword,
      ),
    );
  }
}

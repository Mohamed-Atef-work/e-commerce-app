import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UpdatePasswordUseCase _updatePasswordUseCase;

  ChangePasswordCubit(this._updatePasswordUseCase)
      : super(const ChangePasswordState());

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      if (newPassword.text == confirmPassword.text) {
        emit(state.copyWith(changeState: RequestState.loading));
        final result = await _updatePasswordUseCase.call(UpdatePasswordParams(
            currentPassword: oldPassword.text, newPassword: newPassword.text));
        emit(
          result.fold(
            (l) => state.copyWith(
                changeState: RequestState.error, message: l.message),
            (r) => state.copyWith(changeState: RequestState.success),
          ),
        );
        if(result.isRight()){oldPassword.text = "";newPassword.text = "";confirmPassword.text = "";}
      }
    }
  }
}

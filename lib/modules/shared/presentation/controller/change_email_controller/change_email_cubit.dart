import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  final UpdateEmailUseCase _updateEmailUseCase;

  ChangeEmailCubit(this._updateEmailUseCase) : super(const ChangeEmailState());

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> changeEmail() async {
    if (formKey.currentState!.validate()) {
      state.copyWith(changeState: RequestState.loading);
      final result = await _updateEmailUseCase
          .call(UpdateEmailParams(password: password.text, email: email.text));
      emit(
        result.fold(
          (l) => state.copyWith(
              changeState: RequestState.error, message: l.message),
          (r) => state.copyWith(changeState: RequestState.success),
        ),
      );
    }
  }
}

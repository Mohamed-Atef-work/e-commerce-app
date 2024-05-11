import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(const SignUpState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, email, password;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(signUpState: RequestState.loading));
      final result = await _signUpUseCase(
        SignUpParams(
          name: name!,
          email: email!,
          password: password!,
        ),
      );
      emit(
        result.fold(
          (l) => state.copyWith(
              signUpState: RequestState.error, errorMessage: l.message),
          (r) => state.copyWith(signUpState: RequestState.success),
        ),
      );
    }
  }

  void obSecure() => emit(state.copyWith(obSecure: !state.obSecure));
}

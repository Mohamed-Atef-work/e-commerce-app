import 'dart:async';

import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

import '../../../domain/use_cases/sign_up_use_case.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  final StoreUserDataUseCase storeUserDataUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, email, password;
  SignUpBloc(this.signUpUseCase, this.storeUserDataUseCase)
      : super(const SignUpState());

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      await _signUp().then((_) async {
        await _storeUserDate();
      });
    }
  }

  Future<void> _signUp() async {
    emit(state.copyWith(signUpState: RequestState.loading));
    final result = await signUpUseCase(
      SignUpParameters(
        name: name!,
        email: email!,
        password: password!,
      ),
    );
    emit(result.fold(
      (l) => state.copyWith(
          signUpState: RequestState.error, errorMessage: l.message),
      (r) =>
          state.copyWith(signUpState: RequestState.success, userCredential: r),
    ));
  }

  Future<void> _storeUserDate() async {
    emit(state.copyWith(storeUserDataState: RequestState.loading));
    final result = await storeUserDataUseCase.call(StoreUserDataParameters(
      name: name!,
      email: email!,
      address: "address",
      phone: "phone",
      id: state.userCredential!.user!.uid,
    ));
    emit(result.fold(
        (l) => state.copyWith(storeUserDataState: RequestState.error),
        (r) => state.copyWith(storeUserDataState: RequestState.success)));
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/sign_up_controller/sign_up_states.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final LoginInUseCase _loginInUseCase;
  final StoreUserDataUseCase _storeUserDataUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, email, password;
  SignUpBloc(
      this._signUpUseCase, this._storeUserDataUseCase, this._loginInUseCase)
      : super(const SignUpState());

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      _signUp().then((_) {
        //_signIN().then((_) {
        _storeUserDate();
        // });
      });
    }
  }

  Future<void> _signUp() async {
    emit(state.copyWith(signUpState: RequestState.loading));
    final result = await _signUpUseCase(
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
    final result = await _storeUserDataUseCase.call(
      StoreUserDataParams(
        userModel: UserModel(
          name: name!,
          email: email!,
          address: "address",
          phone: "phone",
          id: state.userCredential!.user!.uid,
        ),
      ),
    );
    emit(result.fold(
      (l) => state.copyWith(
          storeUserDataState: RequestState.error, errorMessage: l.message),
      (r) => state.copyWith(storeUserDataState: RequestState.success),
    ));
  }

  /*Future<void> _signIN() async {
    emit(state.copyWith(signInState: RequestState.loading));

    final result = await _loginInUseCase.call(
      LoginParameters(email: email!, password: password!),
    );
    emit(result.fold(
      (l) => state.copyWith(
          signInState: RequestState.error, errorMessage: l.message),
      (r) {
        uId = r.user!.uid;
        print(uId);
        return state.copyWith(
            signInState: RequestState.success, userCredential: r);
      },
    ));
  }*/
}

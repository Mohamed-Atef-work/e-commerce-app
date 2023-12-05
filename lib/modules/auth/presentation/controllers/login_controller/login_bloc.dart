import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';

import '../../../../../buy_it_app.dart';
import '../../../domain/use_cases/login_use_case.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

  final LoginInUseCase loginInUseCase;
  LoginBloc(
    this.loginInUseCase,
  ) : super(const LoginState()) {
    on<ToggleAdminAndUserEvent>(_toggleAdminUserEvent);
    /*on<TakePasswordEvent>(_takePasswordEvent);
    on<TakeEmailEvent>(_takeEmailEvent);*/
    on<SignInEvent>(_signInEvent);
  }

  FutureOr<void> _signInEvent(
      SignInEvent event, Emitter<LoginState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(
        state.copyWith(requestState: RequestState.loading),
      );

      final result = await loginInUseCase.call(
        LoginParameters(email: email!, password: password!),
      );
      emit(result.fold(
        (l) => state.copyWith(
            requestState: RequestState.error, errorMessage: l.message),
        (r) {
          uId = r.user!.uid;
          print(uId);
          return state.copyWith(
              requestState: RequestState.success, userCredential: r);
        },
      ));
    }
  }

  FutureOr<void> _toggleAdminUserEvent(
      ToggleAdminAndUserEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      adminUser:
          state.adminUser == AdminUser.admin ? AdminUser.user : AdminUser.admin,
    ));
  }

  /*FutureOr<void> _takeEmailEvent(
      TakeEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _takePasswordEvent(
      TakePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }*/
}

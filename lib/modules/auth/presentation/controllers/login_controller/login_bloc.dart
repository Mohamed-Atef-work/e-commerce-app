import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/buy_it_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

  final LoginInUseCase loginInUseCase;
  final SharedDomainRepo _sharedDomainRepo;

  LoginBloc(
    this.loginInUseCase,
    this._sharedDomainRepo,
  ) : super(const LoginState()) {
    on<ToggleAdminAndUserEvent>(_toggleAdminUserEvent);

    on<ObSecureEvent>(_obSecureEvent);
    on<SignInEvent>(_signInEvent);
    on<RebuildEvent>(_reBuildEvent);
    //on<SaveUserDataEvent>(_saveUserDataEvent);
    /*on<TakePasswordEvent>(_takePasswordEvent);
    on<TakeEmailEvent>(_takeEmailEvent);*/
  }

  FutureOr<void> _signInEvent(
      SignInEvent event, Emitter<LoginState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(loginState: RequestState.loading));

      final result = await loginInUseCase.call(
        LoginParams(
            email: email!, password: password!, adminOrUser: event.adminOrUser),
      );
      emit(result.fold(
        (l) => state.copyWith(
            loginState: RequestState.error, errorMessage: l.message),
        (r) =>
            state.copyWith(loginState: RequestState.success, userCredential: r),
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

  FutureOr<void> _obSecureEvent(ObSecureEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(obSecure: !state.obSecure));
  }

/*  FutureOr<void> _saveUserDataEvent(
      SaveUserDataEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
          saveState: RequestState.loading, loginState: RequestState.initial),
    );

    final result = await _sharedDomainRepo.saveUserDataLocally(event.user);
    emit(
      result.fold(
        (l) => state.copyWith(
            errorMessage: l.message, saveState: RequestState.error),
        (r) => state.copyWith(saveState: RequestState.success),
      ),
    );
  }*/

  /*FutureOr<void> _takeEmailEvent(
      TakeEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _takePasswordEvent(
      TakePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }*/

  void _reBuildEvent(RebuildEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(loginState: RequestState.initial));
    print("state.loginState -----------> ${state.loginState}");
  }
}

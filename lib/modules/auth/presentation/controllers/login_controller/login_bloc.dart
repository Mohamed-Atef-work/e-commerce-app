import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_params.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_events.dart';
import 'package:e_commerce_app/modules/auth/presentation/controllers/login_controller/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;
  final AuthRepositoryDomain _authRepo;

  LoginBloc(
    this._authRepo,
  ) : super(const LoginState()) {
    on<ToggleAdminAndUserEvent>(_toggleAdminUserEvent);
    on<ObSecureEvent>(_obSecureEvent);
    on<RebuildEvent>(_reBuildEvent);
    on<SignInEvent>(_logInEvent);
  }

  void _logInEvent(SignInEvent event, Emitter<LoginState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(loginState: RequestState.loading));

      final result = await _authRepo.signIn(
        LoginParams(
            email: email!, password: password!, adminOrUser: event.adminOrUser),
      );
      emit(
        result.fold(
          (l) => state.copyWith(
              loginState: RequestState.error, errorMessage: l.message),
          (r) => state.copyWith(
              loginState: RequestState.success, userCredential: r),
        ),
      );
    }
  }

  void _toggleAdminUserEvent(
      ToggleAdminAndUserEvent event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        adminUser: state.adminUser == AdminUser.admin
            ? AdminUser.user
            : AdminUser.admin,
      ),
    );
  }

  void _obSecureEvent(ObSecureEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(obSecure: !state.obSecure));
  }

  void _reBuildEvent(RebuildEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(loginState: RequestState.initial));
    print(
        "loginState ------ event ----------------------------> ${state.loginState}");
  }
}

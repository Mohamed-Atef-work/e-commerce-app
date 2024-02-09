import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

class LoginState extends Equatable {
  final UserCredential? userCredential;
  final RequestState loginState;
  final String? errorMessage;
  final AdminUser adminUser;
  final bool obSecure;

  const LoginState({
    this.loginState = RequestState.initial,
    this.adminUser = AdminUser.user,
    this.obSecure = true,
    this.userCredential,
    this.errorMessage,
  });

  LoginState copyWith({
    UserCredential? userCredential,
    RequestState? loginState,
    String? errorMessage,
    AdminUser? adminUser,
    bool? obSecure,
  }) =>
      LoginState(
        userCredential: userCredential ?? this.userCredential,
        errorMessage: errorMessage ?? this.errorMessage,
        loginState: loginState ?? this.loginState,
        adminUser: adminUser ?? this.adminUser,
        obSecure: obSecure ?? this.obSecure,
      );

  @override
  List<Object?> get props => [
        userCredential,
        errorMessage,
        loginState,
        adminUser,
        obSecure,
      ];
}

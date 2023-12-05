import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

class LoginState extends Equatable {
  final UserCredential? userCredential;
  final RequestState requestState;
  final String? errorMessage;
  final AdminUser adminUser;

  const LoginState({
    this.requestState = RequestState.initial,
    this.adminUser = AdminUser.user,
    this.userCredential,
    this.errorMessage,
  });

  LoginState copyWith({
    UserCredential? userCredential,
    RequestState? requestState,
    String? errorMessage,
    AdminUser? adminUser,
  }) =>
      LoginState(
        userCredential: userCredential ?? this.userCredential,
        errorMessage: errorMessage ?? this.errorMessage,
        requestState: requestState ?? this.requestState,
        adminUser: adminUser ?? this.adminUser,
      );

  @override
  List<Object?> get props => [
        userCredential,
        errorMessage,
        requestState,
        adminUser,
      ];
}

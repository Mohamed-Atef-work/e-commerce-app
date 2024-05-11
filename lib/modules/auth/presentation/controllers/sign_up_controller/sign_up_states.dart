import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

class SignUpState extends Equatable {
  final UserCredential? userCredential;
  final RequestState? signUpState;
  final String? errorMessage;
  final bool obSecure;

  const SignUpState({
    this.signUpState = RequestState.initial,
    this.obSecure = true,
    this.userCredential,
    this.errorMessage,
  });
  SignUpState copyWith({
    bool? obSecure,
    String? errorMessage,
    RequestState? signUpState,
    UserCredential? userCredential,
  }) =>
      SignUpState(
        obSecure: obSecure ?? this.obSecure,
        signUpState: signUpState ?? this.signUpState,
        errorMessage: errorMessage ?? this.errorMessage,
        userCredential: userCredential ?? this.userCredential,
      );

  @override
  List<Object?> get props => [
        userCredential,
        errorMessage,
        signUpState,
        obSecure,
      ];
}

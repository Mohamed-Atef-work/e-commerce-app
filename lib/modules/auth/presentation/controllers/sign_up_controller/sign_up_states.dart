import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

class SignUpState extends Equatable {
  final RequestState? storeUserDataState;
  final UserCredential? userCredential;
  final RequestState? signUpState;
  final String? errorMessage;

  const SignUpState({
    this.storeUserDataState = RequestState.initial,
    this.signUpState = RequestState.initial,
    this.userCredential,
    this.errorMessage,
  });
  SignUpState copyWith({
    String? errorMessage,
    RequestState? signUpState,
    UserCredential? userCredential,
    RequestState? storeUserDataState,
  }) =>
      SignUpState(
        signUpState: signUpState ?? this.signUpState,
        errorMessage: errorMessage ?? this.errorMessage,
        userCredential: userCredential ?? this.userCredential,
        storeUserDataState: storeUserDataState ?? this.storeUserDataState,
      );

  @override
  List<Object?> get props => [
        storeUserDataState,
        userCredential,
        errorMessage,
        signUpState,
      ];
}

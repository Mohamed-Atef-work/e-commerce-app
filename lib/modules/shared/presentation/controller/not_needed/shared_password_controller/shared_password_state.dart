part of 'shared_password_cubit.dart';

@immutable
class SharedPasswordState {
  final String? message;
  final String? password;
  final RequestState getState;
  final RequestState saveState;
  final RequestState deleteState;

  const SharedPasswordState({
    this.message = "",
    this.password = "",
    this.getState = RequestState.initial,
    this.saveState = RequestState.initial,
    this.deleteState = RequestState.initial,
  });

  SharedPasswordState copyWith({
    String? message,
    String? password,
    RequestState? getState,
    RequestState? saveState,
    RequestState? deleteState,
  }) =>
      SharedPasswordState(
        message: message ?? this.message,
        password: password ?? this.password,
        getState: getState ?? this.getState,
        saveState: saveState ?? this.saveState,
        deleteState: deleteState ?? this.deleteState,
      );
}

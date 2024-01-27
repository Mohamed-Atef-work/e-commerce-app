part of 'change_password_cubit.dart';

@immutable
class ChangePasswordState {
  final RequestState changeState;
  final String message;

  const ChangePasswordState({
    this.changeState = RequestState.initial,
    this.message = "",
  });

  ChangePasswordState copyWith({
    RequestState? changeState,
    String? message,
  }) =>
      ChangePasswordState(
        message: message ?? this.message,
        changeState: changeState ?? this.changeState,
      );
}

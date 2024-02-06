part of 'change_email_cubit.dart';

@immutable
class ChangeEmailState {
  final RequestState changeState;
  final String message;

  const ChangeEmailState({
    this.changeState = RequestState.initial,
    this.message = "",
  });

  ChangeEmailState copyWith({
    RequestState? changeState,
    String? message,
  }) =>
      ChangeEmailState(
        message: message ?? this.message,
        changeState: changeState ?? this.changeState,
      );
}

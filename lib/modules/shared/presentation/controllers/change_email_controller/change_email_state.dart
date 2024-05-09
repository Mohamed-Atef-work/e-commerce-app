part of 'change_email_cubit.dart';

@immutable
class ChangeEmailState {
  final RequestState changeState;
  final bool obSecure;
  final String message;

  const ChangeEmailState({
    this.changeState = RequestState.initial,
    this.obSecure = true,
    this.message = "",
  });

  ChangeEmailState copyWith({
    RequestState? changeState,
    bool? obSecure,
    String? message,
  }) =>
      ChangeEmailState(
        message: message ?? this.message,
        obSecure: obSecure ?? this.obSecure,
        changeState: changeState ?? this.changeState,
      );
}

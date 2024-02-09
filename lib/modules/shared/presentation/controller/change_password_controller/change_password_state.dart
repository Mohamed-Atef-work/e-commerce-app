part of 'change_password_cubit.dart';

@immutable
class ChangePasswordState {
  final RequestState changeState;
  final bool confirmPassword;
  final bool oldPassword;
  final bool newPassword;
  final String message;

  const ChangePasswordState({
    this.changeState = RequestState.initial,
    this.confirmPassword = false,
    this.oldPassword = false,
    this.newPassword = false,
    this.message = "",
  });

  ChangePasswordState copyWith({
    RequestState? changeState,
    bool? confirmPassword,
    bool? oldPassword,
    bool? newPassword,
    String? message,
  }) =>
      ChangePasswordState(
        message: message ?? this.message,
        changeState: changeState ?? this.changeState,
        newPassword: newPassword ?? this.newPassword,
        oldPassword: oldPassword ?? this.oldPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );
}

part of 'logout_cubit.dart';

class LogoutState {
  final RequestState logoutState;
  final String? message;

  LogoutState({
    this.logoutState = RequestState.initial,
    this.message,
  });
  LogoutState copyWith({
    RequestState? logoutState,
    String? message,
  }) =>
      LogoutState(
        logoutState: logoutState ?? this.logoutState,
        message: message ?? this.message,
      );
}

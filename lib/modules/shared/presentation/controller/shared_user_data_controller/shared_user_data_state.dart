part of 'shared_user_data_cubit.dart';

@immutable
class SharedUserDataState {
  final String? message;
  final CachedUserDataEntity? user;
  final RequestState getState;
  final RequestState saveState;
  final RequestState deleteState;

  const SharedUserDataState({
    this.user,
    this.message = "",
    this.getState = RequestState.initial,
    this.saveState = RequestState.initial,
    this.deleteState = RequestState.initial,
  });
  SharedUserDataState copyWith({
    String? message,
    CachedUserDataEntity? user,
    RequestState? getState,
    RequestState? saveState,
    RequestState? deleteState,
  }) =>
      SharedUserDataState(
        user: user ?? this.user,
        message: message ?? this.message,
        getState: getState ?? this.getState,
        saveState: saveState ?? this.saveState,
        deleteState: deleteState ?? this.deleteState,
      );
}

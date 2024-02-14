/*
part of 'init_cubit.dart';

@immutable
class InitState {
  final String message;
  final RequestState dataState;
  final SharedUserDataEntity? SharedUserDataEntity;

  const InitState({
    this.SharedUserDataEntity,
    this.message = "",
    this.dataState = RequestState.loading,
  });
  InitState copyWith({
    String? message,
    RequestState? dataState,
    SharedUserDataEntity? SharedUserDataEntity,
  }) =>
      InitState(
        message: message ?? this.message,
        dataState: dataState ?? this.dataState,
        SharedUserDataEntity: sharedEntity ?? this.sharedEntity,
      );
}
*/

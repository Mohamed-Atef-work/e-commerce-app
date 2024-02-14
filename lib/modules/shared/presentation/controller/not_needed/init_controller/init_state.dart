/*
part of 'init_cubit.dart';

@immutable
class InitState {
  final String message;
  final RequestState dataState;
  final SharedEntity? sharedEntity;

  const InitState({
    this.sharedEntity,
    this.message = "",
    this.dataState = RequestState.loading,
  });
  InitState copyWith({
    String? message,
    RequestState? dataState,
    SharedEntity? sharedEntity,
  }) =>
      InitState(
        message: message ?? this.message,
        dataState: dataState ?? this.dataState,
        sharedEntity: sharedEntity ?? this.sharedEntity,
      );
}
*/

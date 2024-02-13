part of 'init_cubit.dart';

@immutable
class InitState {
  final String message;
  final RequestState dataState;
  final InitEntity? initEntity;

  const InitState({
    this.initEntity,
    this.message = "",
    this.dataState = RequestState.loading,
  });
  InitState copyWith({
    String? message,
    RequestState? dataState,
    InitEntity? initEntity,
  }) =>
      InitState(
        message: message ?? this.message,
        dataState: dataState ?? this.dataState,
        initEntity: initEntity ?? this.initEntity,
      );
}

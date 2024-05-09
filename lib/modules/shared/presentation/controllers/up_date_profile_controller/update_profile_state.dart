part of 'update_profile_cubit.dart';

@immutable
class UpdateProfileState {
  final String message;
  //final UserEntity? userEntity;
  final RequestState updateState;

  const UpdateProfileState({
    //this.userEntity,
    this.message = "",
    this.updateState = RequestState.initial,
  });

  UpdateProfileState copyWith({
    String? message,
    UserEntity? userEntity,
    RequestState? updateState,
  }) =>
      UpdateProfileState(
        message: message ?? this.message,
        //userEntity: userEntity ?? this.userEntity,
        updateState: updateState ?? this.updateState,
      );
}

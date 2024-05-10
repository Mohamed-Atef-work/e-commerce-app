part of 'get_users_who_ordered_cubit.dart';

@immutable
class GetUsersWhoOrderedState {
  final String message;
  final List<UserEntity> usersData;
  final RequestState usersDataState;

  const GetUsersWhoOrderedState({
    this.message = "",
    this.usersData = const [],
    this.usersDataState = RequestState.initial,
  });

  GetUsersWhoOrderedState copyWith({
    String? message,
    List<UserEntity>? usersData,
    RequestState? usersDataState,
  }) =>
      GetUsersWhoOrderedState(
        message: message ?? this.message,
        usersData: usersData ?? this.usersData,
        usersDataState: usersDataState ?? this.usersDataState,
      );
}

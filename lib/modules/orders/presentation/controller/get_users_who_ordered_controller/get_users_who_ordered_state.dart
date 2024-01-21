part of 'get_users_who_ordered_cubit.dart';

@immutable
class GetUsersWhoOrderedState {
  final List<UserEntity> users;
  final RequestState usersState;
  final String message;

  const GetUsersWhoOrderedState({
    this.usersState = RequestState.initial,
    this.users = const [],
    this.message = "",
  });

  GetUsersWhoOrderedState copyWith({
    List<UserEntity>? users,
    RequestState? usersState,
    String? message,
  }) =>
      GetUsersWhoOrderedState(
        usersState: usersState ?? this.usersState,
        message: message ?? this.message,
        users: users ?? this.users,
      );
}

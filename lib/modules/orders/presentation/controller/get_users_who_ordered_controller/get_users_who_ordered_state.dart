part of 'get_users_who_ordered_cubit.dart';

@immutable
class GetUsersWhoOrderedState {
  final String message;
  //final List<String> usersIds;
  final List<UserEntity> usersData;
  final RequestState usersDataState;
  //final RequestState usersIdsState;

  const GetUsersWhoOrderedState({
    //this.usersIdsState = RequestState.initial,
    this.usersDataState = RequestState.initial,
    //this.usersIds = const [],
    this.usersData = const [],
    this.message = "",
  });

  GetUsersWhoOrderedState copyWith({
    String? message,
    //List<String>? usersIds,
    List<UserEntity>? usersData,
    RequestState? usersDataState,
    //RequestState? usersIdsState,
  }) =>
      GetUsersWhoOrderedState(
        usersData: usersData ?? this.usersData,
        message: message ?? this.message,
        //usersIds: usersIds ?? this.usersIds,
        usersDataState: usersDataState ?? this.usersDataState,
        //usersIdsState: usersIdsState ?? this.usersIdsState,
      );
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_users_who_ordered_use_case.dart';
import 'package:meta/meta.dart';

part 'get_users_who_ordered_state.dart';

class GetUsersWhoOrderedCubit extends Cubit<GetUsersWhoOrderedState> {
  final GetUsersWhoOrderedUseCase _getUsersWhoOrderedUseCase;
  GetUsersWhoOrderedCubit(this._getUsersWhoOrderedUseCase)
      : super(const GetUsersWhoOrderedState());

  //StreamSubscription<List<String>>? idsSub;
  StreamSubscription<List<UserEntity>>? usersSub;

  Future<void> getUsers() async {
    print(
        "---------------------------------------- Loading ----------------------------------------");
    await usersSub?.cancel();
    emit(state.copyWith(usersDataState: RequestState.loading));
    final result = _getUsersWhoOrderedUseCase(const NoParams());

    result.fold(
        (l) => emit(
              state.copyWith(
                message: l.message,
                usersDataState: RequestState.error,
              ),
            ), (r) {
      emit(state.copyWith(usersDataState: RequestState.success));
      print(
          "---------------------------------------- success ----------------------------------------");
      usersSub = r.listen((event) {
        print(
            "---------------------------------------- event ----------------------------");
        emit(
          state.copyWith(
            usersData: event,
            usersDataState: RequestState.success,
          ),
        );
      });
    });
  }

  @override
  Future<void> close() async {
    await usersSub?.cancel();
    return super.close();
  }
}

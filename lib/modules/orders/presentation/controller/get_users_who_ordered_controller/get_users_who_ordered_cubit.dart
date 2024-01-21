import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_users_who_ordered_use_case.dart';
import 'package:meta/meta.dart';

part 'get_users_who_ordered_state.dart';

class GetUsersWhoOrderedCubit extends Cubit<GetUsersWhoOrderedState> {
  final GetUsersWhoOrderedUseCase _getUsersWhoOrderedUseCase;
  GetUsersWhoOrderedCubit(this._getUsersWhoOrderedUseCase)
      : super(const GetUsersWhoOrderedState());

  StreamSubscription<List<UserEntity>>? usersSub;

  Future<void> getUsers() async {
    await usersSub?.cancel();
    emit(state.copyWith(usersState: RequestState.loading));
    final result = await _getUsersWhoOrderedUseCase(const NoParameters());

    result.fold(
        (l) => emit(
              state.copyWith(
                  usersState: RequestState.error, message: l.message),
            ), (r) {
      usersSub = r.listen(
        (users) {
          emit(
            state.copyWith(usersState: RequestState.success, users: users),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await usersSub?.cancel();
    return super.close();
  }
}

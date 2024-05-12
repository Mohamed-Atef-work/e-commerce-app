import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:meta/meta.dart';

part 'get_users_who_ordered_state.dart';

class GetUsersWhoOrderedCubit extends Cubit<GetUsersWhoOrderedState> {
  final OrderDomainRepo _orderRepo;
  GetUsersWhoOrderedCubit(this._orderRepo)
      : super(const GetUsersWhoOrderedState());

  StreamSubscription<List<UserEntity>>? usersSub;

  Future<void> getUsers() async {
    await usersSub?.cancel();
    emit(state.copyWith(usersDataState: RequestState.loading));

    final result = _orderRepo.streamUsersWhoOrdered();

    result.fold(
        (l) => emit(
              state.copyWith(
                message: l.message,
                usersDataState: RequestState.error,
              ),
            ), (r) {
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

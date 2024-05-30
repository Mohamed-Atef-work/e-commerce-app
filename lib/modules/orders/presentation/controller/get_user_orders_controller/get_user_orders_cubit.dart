import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

part 'get_user_orders_state.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersState> {
  final OrderDomainRepo _orderRepo;

  StreamSubscription<List<OrderDataEntity>>? ordersSub;

  GetUserOrdersCubit(this._orderRepo) : super(const GetUserOrdersState());

  void getOrders(String uId) async {
    await ordersSub?.cancel();
    emit(state.copyWith(getOrders: RequestState.loading));
    final result = _orderRepo.streamOfUserOrders(uId);

    result.fold(
        (l) => emit(
              state.copyWith(getOrders: RequestState.error, message: l.message),
            ), (r) {
      ordersSub = r.listen(
        (orders) {
          emit(
            state.copyWith(getOrders: RequestState.success, orders: orders),
          );
        },
      );
    });
  }

  void deleteOrder(DeleteOrderParams params) async {
    emit(state.copyWith(deleteOrder: RequestState.loading));
    final result = await _orderRepo.deleteOrder(params);
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, deleteOrder: RequestState.error),
        (r) => state.copyWith(deleteOrder: RequestState.success),
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 10),
      () => emit(state.copyWith(deleteOrder: RequestState.initial)),
    );
  }

  void dismissOrder(int index) {
    List<OrderDataEntity> orders = state.orders;
    orders.removeAt(index);
    emit(state.copyWith(orders: orders));
  }

  @override
  Future<void> close() async {
    await ordersSub?.cancel();
    return super.close();
  }
}

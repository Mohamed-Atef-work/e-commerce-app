import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:meta/meta.dart';

part 'get_user_orders_state.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersState> {
  final GetUserOrdersUseCase _getUserOrders;
  final DeleteOrderUseCase _deleteOrder;

  StreamSubscription<List<OrderDataEntity>>? ordersSub;

  GetUserOrdersCubit(this._getUserOrders, this._deleteOrder)
      : super(const GetUserOrdersState());

  Future<void> getOrders(String uId) async {
    await ordersSub?.cancel();
    emit(state.copyWith(getOrders: RequestState.loading));
    final result = await _getUserOrders.call(uId);

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

  Future<void> deleteOrder(DeleteOrderParams params) async {
    emit(state.copyWith(deleteOrder: RequestState.loading));
    print(state.deleteOrder);
    final result = await _deleteOrder.call(params);
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, deleteOrder: RequestState.error),
        (r) => state.copyWith(deleteOrder: RequestState.success),
      ),
    );
    print(state.deleteOrder);
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

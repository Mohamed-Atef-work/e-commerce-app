import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:equatable/equatable.dart';

part 'manage_user_orders_state.dart';

class ManageUserOrdersCubit extends Cubit<ManageUserOrdersState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  final DeleteOrderUseCase _deleteOrderUseCase;
  ManageUserOrdersCubit(this._getUserOrdersUseCase, this._deleteOrderUseCase)
      : super(const ManageUserOrdersState());
  Future<void> getOrderItems(String uId) async {
    final result = await _getUserOrdersUseCase.call(uId);
    result.fold(
        (l) => emit(
              state.copyWith(
                  getOrdersState: RequestState.error, message: l.message),
            ), (r) {
      r.listen((orders) {
        emit(state.copyWith(
            getOrdersState: RequestState.success, orders: orders));
      });
    });
  }

  Future<void> deleteOrder(DeleteOrderParams params) async {
    final result = await _deleteOrderUseCase.call(params);
    emit(result.fold(
      (l) => state.copyWith(message: l.message),
      (r) => state.copyWith(deleteOrdersState: RequestState.error),
    ));
    print(state.deleteOrdersState);
  }
}

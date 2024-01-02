import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:equatable/equatable.dart';

part 'get_user_orders_state.dart';

class GetUserOrdersCubit extends Cubit<GetUserOrdersState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  GetUserOrdersCubit(this._getUserOrdersUseCase)
      : super(const GetUserOrdersState());
  Future<void> getOrderItems(String uId) async {
    final result = await _getUserOrdersUseCase.call(uId);
    result.fold(
        (l) => emit(
              state.copyWith(
                  ordersState: RequestState.error, message: l.message),
            ), (r) {
      r.listen((orders) {
        emit(state.copyWith(ordersState: RequestState.success, orders: orders));
      });
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:equatable/equatable.dart';

part 'manage_user_orders_state.dart';

class ManageUserOrdersCubit extends Cubit<ManageUserOrdersState> {
  final DeleteOrderUseCase _deleteOrder;
  final GetUserOrdersUseCase _getUserOrders;
  final GetOrderItemsUseCase _getOrderItems;
  final DeleteItemFromOrderUseCase _deleteItemFromOrder;

  StreamSubscription<List<OrderDataEntity>>? ordersSub;

  ManageUserOrdersCubit(
    this._deleteOrder,
    this._getUserOrders,
    this._getOrderItems,
    this._deleteItemFromOrder,
  ) : super(const ManageUserOrdersState());

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

  Future<void> getOrderItems(DocumentReference orderRef) async {
    emit(state.copyWith(getOrderItems: RequestState.loading));
    final result =
        await _getOrderItems.call(GetOrderItemsParams(orderRef: orderRef));
    emit(result.fold(
      (l) =>
          state.copyWith(getOrderItems: RequestState.error, message: l.message),
      (r) => state.copyWith(getOrderItems: RequestState.success, orderItems: r),
    ));
    print(state.getOrderItems);
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

  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params) async {
    emit(state.copyWith(deleteOrderItem: RequestState.loading));
    final result = await _deleteItemFromOrder.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            message: l.message, deleteOrderItem: RequestState.error),
        (r) => state.copyWith(deleteOrderItem: RequestState.success),
      ),
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

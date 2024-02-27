import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';

part 'order_items_state.dart';

class OrderItemsCubit extends Cubit<OrderItemsState> {
  final GetOrderItemsUseCase _getOrderItems;
  final DeleteItemFromOrderUseCase _deleteItemFromOrder;

  StreamSubscription<List<OrderDataEntity>>? ordersSub;

  OrderItemsCubit(
    this._getOrderItems,
    this._deleteItemFromOrder,
  ) : super(const OrderItemsState());

  void getOrderItems(DocumentReference orderRef) async {
    emit(state.copyWith(getOrderItems: RequestState.loading));
    final result =
        await _getOrderItems.call(GetOrderItemsParams(orderRef: orderRef));
    emit(
      result.fold(
        (l) => state.copyWith(
            getOrderItems: RequestState.error, message: l.message),
        (r) =>
            state.copyWith(getOrderItems: RequestState.success, orderItems: r),
      ),
    );
    print(state.getOrderItems);
    print("in The Potatooooooooooooooooooooooooooooooooooooo${state.message}");
  }

  void deleteItemFromOrder(DeleteItemFromOrderParams params) async {
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

  @override
  Future<void> close() async {
    await ordersSub?.cancel();
    return super.close();
  }
}

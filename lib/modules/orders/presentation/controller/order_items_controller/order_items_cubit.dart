import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_items_params.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';

part 'order_items_state.dart';

class OrderItemsCubit extends Cubit<OrderItemsState> {
  final OrderDomainRepo _orderRepo;

  StreamSubscription<List<OrderDataEntity>>? ordersSub;

  OrderItemsCubit(
    this._orderRepo,
  ) : super(const OrderItemsState());

  void getOrderItems(DocumentReference orderRef) async {
    emit(state.copyWith(getOrderItems: RequestState.loading));
    final result =
        await _orderRepo.getOrderItems(GetOrderItemsParams(orderRef: orderRef));
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
    final result = await _orderRepo.deleteItemFromOrder(params);
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

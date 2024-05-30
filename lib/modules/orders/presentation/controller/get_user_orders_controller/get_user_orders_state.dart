part of 'get_user_orders_cubit.dart';

class GetUserOrdersState {
  final List<OrderDataEntity> orders;
  final RequestState getOrders;
  final RequestState deleteOrder;
  final String message;

  const GetUserOrdersState({
    this.getOrders = RequestState.initial,
    this.deleteOrder = RequestState.initial,
    this.orders = const [],
    this.message = "",
  });

  GetUserOrdersState copyWith({
    List<OrderDataEntity>? orders,
    RequestState? getOrders,
    RequestState? deleteOrder,
    String? message,
  }) =>
      GetUserOrdersState(
        getOrders: getOrders ?? this.getOrders,
        deleteOrder: deleteOrder ?? this.deleteOrder,
        message: message ?? this.message,
        orders: orders ?? this.orders,
      );
}

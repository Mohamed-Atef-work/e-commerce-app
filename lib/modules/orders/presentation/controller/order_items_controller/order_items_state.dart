part of 'order_items_cubit.dart';

class OrderItemsState extends Equatable {
  final String message;
  final RequestState getOrderItems;
  final RequestState deleteOrderItem;
  final List<OrderItemEntity> orderItems;

  const OrderItemsState({
    this.message = "",
    this.orderItems = const [],
    this.getOrderItems = RequestState.initial,
    this.deleteOrderItem = RequestState.initial,
  });
  OrderItemsState copyWith({
    String? message,
    RequestState? getOrderItems,
    RequestState? deleteOrderItem,
    List<OrderItemEntity>? orderItems,
  }) =>
      OrderItemsState(
        message: message ?? this.message,
        orderItems: orderItems ?? this.orderItems,
        getOrderItems: getOrderItems ?? this.getOrderItems,
        deleteOrderItem: deleteOrderItem ?? this.deleteOrderItem,
      );
  @override
  List<Object> get props => [
        message,
        orderItems,
        getOrderItems,
        deleteOrderItem,
      ];
}

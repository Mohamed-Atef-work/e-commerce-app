part of 'manage_user_orders_cubit.dart';

class ManageUserOrdersState extends Equatable {
  final String message;
  final RequestState getOrders;
  final RequestState deleteOrder;
  final RequestState getOrderItems;
  final RequestState deleteOrderItem;
  final List<OrderDataEntity> orders;
  final List<OrderItemEntity> orderItems;

  const ManageUserOrdersState({
    this.message = "",
    this.orders = const [],
    this.orderItems = const [],
    this.getOrders = RequestState.initial,
    this.deleteOrder = RequestState.initial,
    this.getOrderItems = RequestState.initial,
    this.deleteOrderItem = RequestState.initial,
  });
  ManageUserOrdersState copyWith({
    String? message,
    RequestState? getOrders,
    RequestState? deleteOrder,
    RequestState? getOrderItems,
    List<OrderDataEntity>? orders,
    RequestState? deleteOrderItem,
    List<OrderItemEntity>? orderItems,
  }) =>
      ManageUserOrdersState(
        orders: orders ?? this.orders,
        message: message ?? this.message,
        getOrders: getOrders ?? this.getOrders,
        orderItems: orderItems ?? this.orderItems,
        deleteOrder: deleteOrder ?? this.deleteOrder,
        getOrderItems: getOrderItems ?? this.getOrderItems,
        deleteOrderItem: deleteOrderItem ?? this.deleteOrderItem,
      );
  @override
  List<Object> get props => [
        orders,
        message,
        getOrders,
        orderItems,
        deleteOrder,
        getOrderItems,
        deleteOrderItem,
      ];
}

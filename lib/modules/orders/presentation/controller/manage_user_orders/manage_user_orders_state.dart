part of 'manage_user_orders_cubit.dart';

class ManageUserOrdersState extends Equatable {
  final String message;
  final RequestState getOrdersState;
  final RequestState deleteOrdersState;
  final List<OrderDataEntity> orders;

  const ManageUserOrdersState({
    this.message = "",
    this.orders = const [],
    this.getOrdersState = RequestState.initial,
    this.deleteOrdersState = RequestState.initial,
  });
  ManageUserOrdersState copyWith({
    String? message,
    RequestState? getOrdersState,
    RequestState? deleteOrdersState,
    List<OrderDataEntity>? orders,
  }) =>
      ManageUserOrdersState(
        orders: orders ?? this.orders,
        message: message ?? this.message,
        getOrdersState: getOrdersState ?? this.getOrdersState,
        deleteOrdersState: deleteOrdersState ?? this.deleteOrdersState,
      );
  @override
  List<Object> get props => [
        message,
        orders,
        getOrdersState,
        deleteOrdersState,
      ];
}

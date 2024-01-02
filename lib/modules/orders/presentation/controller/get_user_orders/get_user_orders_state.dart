part of 'get_user_orders_cubit.dart';

class GetUserOrdersState extends Equatable {
  final String message;
  final RequestState ordersState;
  final List<OrderDataEntity> orders;

  const GetUserOrdersState({
    this.message = "",
    this.orders = const [],
    this.ordersState = RequestState.initial,
  });
  GetUserOrdersState copyWith({
    String? message,
    RequestState? ordersState,
    List<OrderDataEntity>? orders,
  }) =>
      GetUserOrdersState(
        orders: orders ?? this.orders,
        message: message ?? this.message,
        ordersState: ordersState ?? this.ordersState,
      );
  @override
  List<Object> get props => [
        message,
        orders,
        ordersState,
      ];
}

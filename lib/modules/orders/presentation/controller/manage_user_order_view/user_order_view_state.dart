part of 'user_order_view_cubit.dart';

class ManageUserOrderViewState {
  final UserOrderViewState orderState;

  const ManageUserOrderViewState({
    this.orderState = UserOrderViewState.viewOrders,
  });

  ManageUserOrderViewState copyWith({
    UserOrderViewState? orderState,
  }) =>
      ManageUserOrderViewState(orderState: orderState ?? this.orderState);
}

enum UserOrderViewState {
  viewOrders,
  viewOrderItems,
}

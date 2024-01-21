part of 'admin_order_view_cubit.dart';

class ManageAdminOrderViewState {
  final AdminOrderViewState view;

  const ManageAdminOrderViewState({
    this.view = AdminOrderViewState.users,
  });

  ManageAdminOrderViewState copyWith({
    AdminOrderViewState? view,
  }) =>
      ManageAdminOrderViewState(view: view ?? this.view);
}

enum AdminOrderViewState {
  users,
  userOrders,
  orderItems,
}

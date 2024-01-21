import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_order_view_state.dart';

class ManageAdminOrderViewCubit extends Cubit<ManageAdminOrderViewState> {
  ManageAdminOrderViewCubit() : super(const ManageAdminOrderViewState());
  void viewUsers() {
    emit(state.copyWith(view: AdminOrderViewState.users));
  }

  void viewOrders() {
    emit(state.copyWith(view: AdminOrderViewState.userOrders));
  }

  void viewOrderItems() {
    emit(state.copyWith(view: AdminOrderViewState.orderItems));
  }
}

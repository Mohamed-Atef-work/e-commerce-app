import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_order_view_state.dart';

class ManageUserOrderViewCubit extends Cubit<ManageUserOrderViewState> {
  ManageUserOrderViewCubit() : super(const ManageUserOrderViewState());
  void viewOrders() {
    emit(state.copyWith(orderState: UserOrderViewState.viewOrders));
  }

  void viewOrderItems() {
    emit(state.copyWith(orderState: UserOrderViewState.viewOrderItems));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_states.dart';

class AdminLayoutCubit extends Cubit<AdminLayoutState> {
  AdminLayoutCubit() : super(const AdminLayoutState());

  final List<String> _titles = [
    AppStrings.products,
    AppStrings.orders,
    AppStrings.favorites,
    AppStrings.profile,
  ];
  void newScreen(int index) {
    emit(AdminLayoutState(currentIndex: index, appBarTitle: _titles[index]));
  }
}

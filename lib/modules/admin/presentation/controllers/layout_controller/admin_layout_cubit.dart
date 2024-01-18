import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/layout_controller/admin_layout_states.dart';

class AdminLayoutCubit extends Cubit<AdminLayoutState> {
  AdminLayoutCubit() : super(const AdminLayoutState());

  final List<String> _titles = [
    AppStrings.profile,
    AppStrings.categories,
    AppStrings.favorites,
    AppStrings.account,
  ];
  void newScreen(int index) {
    emit(AdminLayoutState(currentIndex: index, appBarTitle: _titles[index]));
  }
}

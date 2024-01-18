import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/user_layout_controller/user_layout_states.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(const UserLayoutState());

  final List<String> _titles = [
    AppStrings.profile,
    AppStrings.categories,
    AppStrings.favorites,
    AppStrings.account,
  ];
  void newScreen(int index) {
    emit(UserLayoutState(currentIndex: index, appBarTitle: _titles[index]));
  }
}

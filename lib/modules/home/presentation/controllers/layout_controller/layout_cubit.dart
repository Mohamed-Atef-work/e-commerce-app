import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/layout_controller/layout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutState());

  final List<String> _titles = [
    AppStrings.profile,
    AppStrings.categories,
    AppStrings.favorites,
  ];
  void newScreen(int index) {
    emit(LayoutState(currentIndex: index, appBarTitle: _titles[index]));
  }
}

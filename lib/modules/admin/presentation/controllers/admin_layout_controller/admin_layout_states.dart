import 'package:e_commerce_app/core/utils/app_strings.dart';

class AdminLayoutState {
  final int currentIndex;
  final String appBarTitle;

  const AdminLayoutState({
    this.currentIndex = 0,
    this.appBarTitle = AppStrings.categories,
  });
}

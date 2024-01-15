import 'package:e_commerce_app/core/utils/app_strings.dart';

class LayoutState {
  final int currentIndex;
  final String appBarTitle;

  const LayoutState({
    this.currentIndex = 0,
    this.appBarTitle = AppStrings.categories,
  });
}

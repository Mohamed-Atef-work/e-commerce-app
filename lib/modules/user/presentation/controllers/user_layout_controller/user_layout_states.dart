import 'package:e_commerce_app/core/utils/app_strings.dart';

class UserLayoutState {
  final int currentIndex;
  final String appBarTitle;

  const UserLayoutState({
    this.currentIndex = 0,
    this.appBarTitle = AppStrings.categories,
  });
}

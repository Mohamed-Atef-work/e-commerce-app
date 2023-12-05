import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';

class CategoriesModelSheetState extends Equatable {
  final String? message;
  final RequestState? addCategoryState;
  final RequestState? deleteCategoryState;
  final RequestState? updateCategoryState;

  const CategoriesModelSheetState({
    this.message,
    this.addCategoryState = RequestState.initial,
    this.deleteCategoryState = RequestState.initial,
    this.updateCategoryState = RequestState.initial,
  });
  CategoriesModelSheetState copyWith({
    String? message,
    RequestState? addCategoryState,
    RequestState? deleteCategoryState,
    RequestState? updateCategoryState,}
  ) =>
      CategoriesModelSheetState(
        message: message ?? this.message,
        addCategoryState: addCategoryState ?? this.addCategoryState,
        deleteCategoryState: deleteCategoryState ?? this.deleteCategoryState,
        updateCategoryState: updateCategoryState ?? this.updateCategoryState,
      );

  @override
  List<Object?> get props => [
        message,
        deleteCategoryState,
        addCategoryState,
        updateCategoryState,
      ];
}

import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';

class CategoriesModelSheetState extends Equatable {
  final String? message;
  final RequestState? categoryState;
  final RequestState? addCategoryState;

  const CategoriesModelSheetState({
    this.message,
    this.categoryState = RequestState.initial,
    this.addCategoryState = RequestState.initial,
  });
  CategoriesModelSheetState copyWith({
    String? message,
    RequestState? addCategoryState,
    RequestState? categoryState,
  }) =>
      CategoriesModelSheetState(
        message: message ?? this.message,
        categoryState: categoryState ?? this.categoryState,
        addCategoryState: addCategoryState ?? this.addCategoryState,
      );

  @override
  List<Object?> get props => [
        message,
        categoryState,
        addCategoryState,
      ];
}

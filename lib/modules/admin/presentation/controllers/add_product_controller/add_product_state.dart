import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';

class AddProductState extends Equatable {
  final List<ProductCategoryEntity>? categories;
  final RequestState getCategoriesState;
  final RequestState productState;
  final String? errorMessage;
  final String? imagePath;
  final bool thereIsImage;
  final int categoryIndex;

  const AddProductState({
    this.getCategoriesState = RequestState.initial,
    this.productState = RequestState.initial,
    this.thereIsImage = false,
    this.categories = const [],
    this.categoryIndex = 0,
    this.errorMessage,
    this.imagePath,
  });
  AddProductState copyWith({
    List<ProductCategoryEntity>? categories,
    RequestState? getCategoriesState,
    RequestState? productState,
    String? errorMessage,
    bool? thereIsImage,
    String? imagePath,
    int? categoryIndex,
  }) =>
      AddProductState(
        getCategoriesState: getCategoriesState ?? this.getCategoriesState,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        productState: productState ?? this.productState,
        errorMessage: errorMessage ?? this.errorMessage,
        thereIsImage: thereIsImage ?? this.thereIsImage,
        categories: categories ?? this.categories,
        imagePath: imagePath ?? this.imagePath,
      );

  @override
  List<Object?> get props => [
        getCategoriesState,
        categoryIndex,
        errorMessage,
        thereIsImage,
        productState,
        categories,
        imagePath,
      ];
}

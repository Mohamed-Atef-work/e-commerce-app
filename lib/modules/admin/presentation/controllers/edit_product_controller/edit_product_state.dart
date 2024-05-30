import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';

class EditProductState extends Equatable {
  final List<ProductCategoryEntity>? categories;
  final ProductEntity? productToBeUpdated;
  final RequestState getCategoriesState;
  final RequestState productState;
  final ImageState imageState;
  final String? errorMessage;
  final String? imagePath;
  final String? productId;
  final int? categoryIndex;

  const EditProductState({
    this.getCategoriesState = RequestState.initial,
    this.productState = RequestState.initial,
    this.imageState = ImageState.noImage,
    this.categories = const [],
    this.productToBeUpdated,
    this.categoryIndex,
    this.errorMessage,
    this.productId,
    this.imagePath,
  });
  EditProductState copyWith({
    List<ProductCategoryEntity>? categories,
    ProductEntity? productToBeUpdated,
    RequestState? getCategoriesState,
    RequestState? productState,
    ImageState? imageState,
    String? errorMessage,
    int? categoryIndex,
    String? imagePath,
    String? productId,
  }) =>
      EditProductState(
        productToBeUpdated: productToBeUpdated ?? this.productToBeUpdated,
        getCategoriesState: getCategoriesState ?? this.getCategoriesState,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        productState: productState ?? this.productState,
        errorMessage: errorMessage ?? this.errorMessage,
        categories: categories ?? this.categories,
        imageState: imageState ?? this.imageState,
        imagePath: imagePath ?? this.imagePath,
        productId: productId ?? this.productId,
      );

  @override
  List<Object?> get props => [
        productToBeUpdated,
        getCategoriesState,
        categoryIndex,
        errorMessage,
        productState,
        imageState,
        categories,
        imagePath,
        productId
      ];
}

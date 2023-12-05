import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class EditAddProductState extends Equatable {
  final List<ProductCategoryEntity>? categories;
  final ProductEntity? productToBeUpdated;
  final RequestState downloadImageState;
  final RequestState getCategoriesState;
  final RequestState uploadImageState;
  final String addUpdateButtonText;
  final RequestState productState;
  final String imageButtonText;
  final ImageState imageState;
  final String? errorMessage;
  final String? imagePath;
  final bool thereIsImage;
  final int categoryIndex;

  const EditAddProductState({
    this.getCategoriesState = RequestState.initial,
    this.downloadImageState = RequestState.initial,
    this.uploadImageState = RequestState.initial,
    this.imageButtonText = AppStrings.addAnImage,
    this.addUpdateButtonText = AppStrings.add,
    this.productState = RequestState.initial,
    this.imageState = ImageState.noImage,
    this.thereIsImage = false,
    this.productToBeUpdated,
    this.errorMessage,
    this.imagePath,
    this.categories = const [],
    this.categoryIndex = 0,
  });
  EditAddProductState copyWith({
    List<ProductCategoryEntity>? categories,
    ProductEntity? productToBeUpdated,
    RequestState? getCategoriesState,
    RequestState? downloadImageState,
    RequestState? uploadImageState,
    String? addUpdateButtonText,
    RequestState? productState,
    String? imageButtonText,
    ImageState? imageState,
    String? errorMessage,
    bool? thereIsImage,
    String? imagePath,
    int? categoryIndex,
  }) =>
      EditAddProductState(
        addUpdateButtonText: addUpdateButtonText ?? this.addUpdateButtonText,
        productToBeUpdated: productToBeUpdated ?? this.productToBeUpdated,
        downloadImageState: downloadImageState ?? this.downloadImageState,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        imageButtonText: imageButtonText ?? this.imageButtonText,
        getCategoriesState: getCategoriesState ?? this.getCategoriesState,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        productState: productState ?? this.productState,
        errorMessage: errorMessage ?? this.errorMessage,
        thereIsImage: thereIsImage ?? this.thereIsImage,
        categories: categories ?? this.categories,
        imageState: imageState ?? this.imageState,
        imagePath: imagePath ?? this.imagePath,
      );

  @override
  List<Object?> get props => [
        addUpdateButtonText,
        downloadImageState,
        productToBeUpdated,
        getCategoriesState,
        uploadImageState,
        imageButtonText,
        categoryIndex,
        errorMessage,
        thereIsImage,
        productState,
        imageState,
        categories,
        imagePath,
      ];
}

part of 'home_screen_cubit.dart';

@immutable
class ProductsViewState {
  final RequestState categoriesState;
  final RequestState productsState;
  final List<ProductEntity> products;
  final List<ProductCategoryEntity> categories;
  final int categoryIndex;
  final String? message;

  const ProductsViewState({
    this.categoriesState = RequestState.initial,
    this.productsState = RequestState.initial,
    this.products = const [],
    this.categories = const [],
    this.categoryIndex = 0,
    this.message,
  });
  ProductsViewState copyWith({
    List<ProductEntity>? products,
    List<ProductCategoryEntity>? categories,
    RequestState? productsState,
    RequestState? categoriesState,
    int? categoryIndex,
    String? message,
  }) =>
      ProductsViewState(
        message: message ?? this.message,
        products: products ?? this.products,
        categories: categories ?? this.categories,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        productsState: productsState ?? this.productsState,
        categoriesState: categoriesState ?? this.categoriesState,
      );
}

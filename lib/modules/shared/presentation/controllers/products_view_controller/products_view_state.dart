part of 'products_view_cubit.dart';

@immutable
class ProductsViewState {
  final List<ProductCategoryEntity> categories;
  final List<ProductEntity> products;
  final RequestState categoriesState;
  final RequestState productsState;
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
    List<ProductCategoryEntity>? categories,
    RequestState? categoriesState,
    List<ProductEntity>? products,
    RequestState? productsState,
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

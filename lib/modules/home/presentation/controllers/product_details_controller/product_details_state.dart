part of 'product_details_cubit.dart';

@immutable
class ProductDetailsState extends Equatable {
  final ProductEntity? selectedProduct;
  final List<ProductEntity>? products;
  final RequestState? favoriteState;
  final RequestState? productsState;
  final RequestState? cartState;
  final String? message;

  const ProductDetailsState({
    this.favoriteState = RequestState.initial,
    this.productsState = RequestState.initial,
    this.cartState = RequestState.initial,
    this.products = const [],
    this.selectedProduct,
    this.message = "",
  });
  ProductDetailsState copyWith({
    ProductEntity? selectedProduct,
    List<ProductEntity>? products,
    RequestState? favoriteState,
    RequestState? productsState,
    RequestState? cartState,
    String? message,
  }) =>
      ProductDetailsState(
        selectedProduct: selectedProduct ?? this.selectedProduct,
        favoriteState: favoriteState ?? this.favoriteState,
        productsState: productsState ?? this.productsState,
        cartState: cartState ?? this.cartState,
        products: products ?? this.products,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        selectedProduct,
        favoriteState,
        productsState,
        cartState,
        products,
        message,
      ];
}

part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final String? message;
  final RequestState getCartState;
  final RequestState deleteState;
  final List<ProductEntity> products;

  const ManageCartProductsState({
    this.message,
    this.products = const [],
    this.deleteState = RequestState.initial,
    this.getCartState = RequestState.initial,
  });
  ManageCartProductsState copyWith({
    String? message,
    RequestState? getCartState,
    RequestState? deleteState,
    List<ProductEntity>? products,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        products: products ?? this.products,
        deleteState: deleteState ?? this.deleteState,
        getCartState: getCartState ?? this.getCartState,
      );
}

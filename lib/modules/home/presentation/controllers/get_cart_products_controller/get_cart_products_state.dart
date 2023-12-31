part of 'get_cart_products_cubit.dart';

class GetCartProductsState {
  final String? message;
  final RequestState getCartState;
  final List<CartEntity> products;

  const GetCartProductsState({
    this.message,
    this.products = const [],
    this.getCartState = RequestState.initial,
  });
  GetCartProductsState copyWith({
    String? message,
    RequestState? getCartState,
    List<CartEntity>? products,
  }) =>
      GetCartProductsState(
        message: message ?? this.message,
        getCartState: getCartState ?? this.getCartState,
        products: products ?? this.products,
      );
}

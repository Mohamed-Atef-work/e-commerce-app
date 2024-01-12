part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final List<ProductEntity> products;
  final RequestState deleteFromCart;
  final RequestState addToCart;
  final RequestState clearCart;
  final RequestState addOrder;
  final RequestState getCart;
  final List<int> quantities;
  final bool needToReGet;
  final String? message;

  const ManageCartProductsState({
    this.message,
    this.quantities = const [],
    this.products = const [],
    this.needToReGet = true,
    this.deleteFromCart = RequestState.initial,
    this.addToCart = RequestState.initial,
    this.clearCart = RequestState.initial,
    this.addOrder = RequestState.initial,
    this.getCart = RequestState.initial,
  });
  ManageCartProductsState copyWith({
    String? message,
    bool? needToReGet,
    List<int>? quantities,
    RequestState? getCart,
    RequestState? addOrder,
    RequestState? clearCart,
    RequestState? addToCart,
    RequestState? deleteFromCart,
    List<ProductEntity>? products,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        getCart: getCart ?? this.getCart,
        products: products ?? this.products,
        addOrder: addOrder ?? this.addOrder,
        clearCart: clearCart ?? this.clearCart,
        addToCart: addToCart ?? this.addToCart,
        quantities: quantities ?? this.quantities,
        needToReGet: needToReGet ?? this.needToReGet,
        deleteFromCart: deleteFromCart ?? this.deleteFromCart,
      );
}

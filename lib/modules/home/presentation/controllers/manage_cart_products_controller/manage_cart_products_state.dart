part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final bool needToReGet;
  final String? message;
  final RequestState addToCart;
  final RequestState addOrder;
  final RequestState deleteFromCart;
  final RequestState getCart;
  final List<int> quantities;
  final List<ProductEntity> products;

  const ManageCartProductsState({
    this.message,
    this.quantities = const [],
    this.needToReGet = true,
    this.products = const [],
    this.addToCart = RequestState.initial,
    this.deleteFromCart = RequestState.initial,
    this.addOrder = RequestState.initial,
    this.getCart = RequestState.initial,
  });
  ManageCartProductsState copyWith({
    String? message,
    bool? needToReGet,
    RequestState? getCart,
    List<int>? quantities,
    RequestState? addOrder,
    RequestState? addToCart,
    RequestState? deleteFromCart,
    List<ProductEntity>? products,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        getCart: getCart ?? this.getCart,
        products: products ?? this.products,
        addOrder: addOrder ?? this.addOrder,
        addToCart: addToCart ?? this.addToCart,
        quantities: quantities ?? this.quantities,
        needToReGet: needToReGet ?? this.needToReGet,
        deleteFromCart: deleteFromCart ?? this.deleteFromCart,
      );
}

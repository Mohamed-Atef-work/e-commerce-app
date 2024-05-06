part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final List<CartItemEntity> products;
  final List<int> notExistedProducts;
  final RequestState deleteFromCart;
  final RequestState addOrder;
  final RequestState getCart;
  final bool needToReGet;
  final String? message;

  const ManageCartProductsState({
    this.deleteFromCart = RequestState.initial,
    this.addOrder = RequestState.initial,
    this.getCart = RequestState.initial,
    this.notExistedProducts = const [],
    this.products = const [],
    this.needToReGet = true,
    this.message,
  });
  ManageCartProductsState copyWith({
    String? message,
    bool? needToReGet,
    RequestState? getCart,
    RequestState? addOrder,
    RequestState? deleteFromCart,
    List<int>? notExistedProducts,
    List<CartItemEntity>? products,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        getCart: getCart ?? this.getCart,
        addOrder: addOrder ?? this.addOrder,
        products: products ?? this.products,
        needToReGet: needToReGet ?? this.needToReGet,
        deleteFromCart: deleteFromCart ?? this.deleteFromCart,
        notExistedProducts: notExistedProducts ?? this.notExistedProducts,
      );
}

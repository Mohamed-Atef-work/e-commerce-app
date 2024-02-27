part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final RequestState getProductsQuantities;
  final List<CartItemEntity> products;
  final RequestState deleteFromCart;
  //final RequestState clearCart;
  final RequestState addOrder;
  final RequestState getCart;
  //final List<int> quantities;
  final bool needToReGet;
  final String? message;

  const ManageCartProductsState({
    this.getProductsQuantities = RequestState.initial,
    this.deleteFromCart = RequestState.initial,
    //this.clearCart = RequestState.initial,
    this.addOrder = RequestState.initial,
    this.getCart = RequestState.initial,
    //this.quantities = const [],
    this.products = const [],
    this.needToReGet = true,
    this.message,
  });
  ManageCartProductsState copyWith({
    String? message,
    bool? needToReGet,
    //List<int>? quantities,
    RequestState? getCart,
    RequestState? addOrder,
    //RequestState? clearCart,
    RequestState? deleteFromCart,
    List<CartItemEntity>? products,
    RequestState? getProductsQuantities,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        getCart: getCart ?? this.getCart,
        addOrder: addOrder ?? this.addOrder,
        products: products ?? this.products,
        //clearCart: clearCart ?? this.clearCart,
        //quantities: quantities ?? this.quantities,
        needToReGet: needToReGet ?? this.needToReGet,
        deleteFromCart: deleteFromCart ?? this.deleteFromCart,
        getProductsQuantities:
            getProductsQuantities ?? this.getProductsQuantities,
      );
}

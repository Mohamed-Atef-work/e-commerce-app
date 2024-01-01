part of 'manage_cart_products_cubit.dart';

class ManageCartProductsState {
  final bool needToReGet;
  final String? message;
  final RequestState addState;
  final RequestState deleteState;
  final RequestState getCartState;
  final List<ProductEntity> products;

  const ManageCartProductsState({
    this.message,
    this.needToReGet = true,
    this.products = const [],
    this.addState = RequestState.initial,
    this.deleteState = RequestState.initial,
    this.getCartState = RequestState.initial,
  });
  ManageCartProductsState copyWith({
    String? message,
    bool? needToReGet,
    RequestState? addState,
    RequestState? deleteState,
    RequestState? getCartState,
    List<ProductEntity>? products,
  }) =>
      ManageCartProductsState(
        message: message ?? this.message,
        products: products ?? this.products,
        addState: addState ?? this.addState,
        needToReGet: needToReGet ?? this.needToReGet,
        deleteState: deleteState ?? this.deleteState,
        getCartState: getCartState ?? this.getCartState,
      );
}

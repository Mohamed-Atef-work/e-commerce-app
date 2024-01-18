/*
class ProductDetailsState extends Equatable {
  final ProductEntity? product;
  final RequestState addToCart;
  final String? message;
  final int quantity;

  const ProductDetailsState({
    this.product,
    this.quantity = 1,
    this.message = "",
    this.addToCart = RequestState.initial,
  });
  ProductDetailsState copyWith({
    RequestState? addToCart,
    ProductEntity? product,
    String? message,
    int? quantity,
  }) =>
      ProductDetailsState(
        product: product ?? this.product,
        addToCart: addToCart ?? this.addToCart,
        quantity: quantity ?? this.quantity,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        product,
        addToCart,
        quantity,
        message,
      ];
}

*/

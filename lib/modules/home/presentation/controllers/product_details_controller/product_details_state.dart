part of 'product_details_cubit.dart';

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
    int? quantity,
    String? message,
    ProductEntity? product,
    RequestState? addToCart,
  }) =>
      ProductDetailsState(
        product: product ?? this.product,
        message: message ?? this.message,
        quantity: quantity ?? this.quantity,
        addToCart: addToCart ?? this.addToCart,
      );

  @override
  List<Object?> get props => [
        product,
        message,
        quantity,
        addToCart,
      ];
}

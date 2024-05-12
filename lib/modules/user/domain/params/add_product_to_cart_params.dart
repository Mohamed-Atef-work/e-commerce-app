import 'package:equatable/equatable.dart';

class AddToCartParams extends Equatable {
  final String uId;
  final int quantity;
  final String category;
  final String productId;

  const AddToCartParams({
    required this.uId,
    required this.quantity,
    required this.category,
    required this.productId,
  });

  @override
  List<Object?> get props => [
        uId,
        quantity,
        category,
        productId,
      ];
}

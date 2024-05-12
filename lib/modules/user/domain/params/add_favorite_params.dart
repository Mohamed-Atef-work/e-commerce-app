import 'package:equatable/equatable.dart';

class AddDeleteFavoriteParams extends Equatable {
  final String category;
  final String productId;
  final String uId;

  const AddDeleteFavoriteParams({
    required this.category,
    required this.productId,
    required this.uId,
  });

  @override
  List<Object?> get props => [
        uId,
        category,
        productId,
      ];
}

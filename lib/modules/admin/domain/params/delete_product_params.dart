import 'package:equatable/equatable.dart';

class DeleteProductParams extends Equatable {
  final String productId;
  final String category;

  const DeleteProductParams(this.productId, this.category);

  @override
  List<Object?> get props => [
        productId,
        category,
      ];
}

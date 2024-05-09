import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final List<ProductEntity> products;
  final String category;

  const FavoriteEntity({
    required this.category,
    required this.products,
  });

  @override
  List<Object?> get props => [
        category,
        products,
      ];
}

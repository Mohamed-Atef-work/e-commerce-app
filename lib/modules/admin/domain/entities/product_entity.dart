import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String description;
  final String category;
  final String image;
  final String name;
  final String? id;
  final num price;

  const ProductEntity({
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        description,
        category,
        price,
        image,
        name,
        id,
      ];
}

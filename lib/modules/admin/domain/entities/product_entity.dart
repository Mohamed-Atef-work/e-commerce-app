import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String description;
  final String category;
  final String location;
  final String image;
  final num price;
  final String name;
  final String? id;

  const ProductEntity({
    required this.id,
    required this.description,
    required this.location,
    required this.category,
    required this.price,
    required this.image,
    required this.name,
  });

  @override
  List<Object?> get props => [
        description,
        location,
        category,
        price,
        image,
        name,
        id,
      ];
}

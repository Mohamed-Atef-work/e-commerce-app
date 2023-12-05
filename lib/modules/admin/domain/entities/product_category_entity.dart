import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  final String name;
  final String id;

  const ProductCategoryEntity({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}

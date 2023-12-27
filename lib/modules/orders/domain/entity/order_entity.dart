import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final List<ItemEntity> items;
  final String phoneNumber;
  final double totalPrice;
  final String address;
  final String name;

  const OrderEntity({
    required this.phoneNumber,
    required this.totalPrice,
    required this.address,
    required this.items,
    required this.name,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        totalPrice,
        address,
        items,
        name,
      ];
}

class ItemEntity extends Equatable {
  final String description;
  final String category;
  final String location;
  final String image;
  final String price;
  final int quantity;
  final String name;
  final String id;

  const ItemEntity({
    required this.quantity,
    required this.description,
    required this.location,
    required this.category,
    required this.price,
    required this.image,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        description,
        quantity,
        location,
        category,
        price,
        image,
        name,
        id,
      ];
}

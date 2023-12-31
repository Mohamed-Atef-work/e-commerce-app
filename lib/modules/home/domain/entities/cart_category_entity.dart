import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartCategoryEntity extends Equatable {
  final String id;
  final DocumentReference reference;

  const CartCategoryEntity({
    required this.id,
    required this.reference,
  });

  @override
  List<Object?> get props => [
        id,
        reference,
      ];
}

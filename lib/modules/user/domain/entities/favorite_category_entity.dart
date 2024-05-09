import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FavoriteCategoryEntity extends Equatable {
  final String id;
  final DocumentReference reference;

  const FavoriteCategoryEntity({
    required this.id,
    required this.reference,
  });

  @override
  List<Object?> get props => [
        id,
        reference,
      ];
}

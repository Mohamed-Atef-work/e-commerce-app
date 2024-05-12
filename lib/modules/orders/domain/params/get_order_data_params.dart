import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetOrderDataParams extends Equatable {
  final DocumentReference orderRef;

  const GetOrderDataParams({required this.orderRef});

  @override
  List<Object?> get props => [orderRef];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetOrderItemsParams extends Equatable {
  final DocumentReference orderRef;

  const GetOrderItemsParams({required this.orderRef});

  @override
  List<Object> get props => [orderRef];
}

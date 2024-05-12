import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DeleteOrderParams extends Equatable {
  //final List<String> orderItemsIds;
  final DocumentReference orderRef;
  final String uId;

  const DeleteOrderParams(
      {
      //required this.orderItemsIds,
      required this.orderRef,
      required this.uId});

  @override
  List<Object?> get props => [
        orderRef, //orderItemsIds
      ];
}

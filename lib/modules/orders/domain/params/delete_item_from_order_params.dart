import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteItemFromOrderParams {
  final DocumentReference itemRef;

  DeleteItemFromOrderParams({
    required this.itemRef,
  });
}

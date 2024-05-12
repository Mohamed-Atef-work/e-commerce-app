import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';

class AddItemToOrderParams {
  final DocumentReference orderRef;
  final OrderItemModel item;

  AddItemToOrderParams({
    required this.orderRef,
    required this.item,
  });
}

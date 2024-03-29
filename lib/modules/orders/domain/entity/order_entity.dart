import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final DocumentReference orderRer;
  //final OrderDataEntity orderData;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.orderRer,
    //required this.orderData,
    required this.items,
  });

  @override
  List<Object> get props => [
        //orderData,
        items,
      ];
}

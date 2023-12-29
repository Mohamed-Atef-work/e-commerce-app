import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final OrderDataEntity orderData;
  final List<ItemEntity> items;

  const OrderEntity({
    required this.orderData,
    required this.items,
  });

  @override
  List<Object> get props => [
        orderData,
        items,
      ];
}

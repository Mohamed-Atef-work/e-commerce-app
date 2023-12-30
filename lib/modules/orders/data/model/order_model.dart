import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.items,
    required super.orderData,
  });
  factory OrderModel.fromJson({
    required json,
    required OrderDataEntity orderData,
  }) =>
      OrderModel(
        orderData: orderData,
        items: List<OrderItemEntity>.of(
          json.map(
            (item) => OrderItemModel.fromJson(
              productId: item.id,
              json: item,
            ),
          ),
        ).toList(),
      );
}

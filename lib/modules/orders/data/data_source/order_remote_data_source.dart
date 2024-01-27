import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/order.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_item_to_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';

abstract class OrderBaseRemoteDataSource {
  Future<List<OrderItemEntity>> getOrderItems(GetOrderItemsParams params);
  Future<Stream<List<OrderDataEntity>>> streamOfUserOrders(String userId);
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params);
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params);
  Future<List<OrderDataEntity>> getUserOrders(String userId);
  Future<void> updateOrderData(UpDateOrderDataParams params);
  Future<Stream<List<String>>> streamUsersWhoOrdered();
  Future<void> addItemToOrder(AddItemToOrderParams params);
  Future<void> deleteOrder(DeleteOrderParams params);
  Future<void> addOrder(AddOrderParams params);
}

class OrderRemoteDataSource implements OrderBaseRemoteDataSource {
  final OrderStore orderStore;

  OrderRemoteDataSource(this.orderStore);
  @override
  Future<void> updateOrderData(UpDateOrderDataParams params) async {
    await orderStore.updateOrderData(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> addItemToOrder(AddItemToOrderParams params) async {
    await orderStore.addItemToOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> addOrder(AddOrderParams params) async {
    await orderStore.addOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params) async {
    await orderStore.deleteItemFromOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> deleteOrder(DeleteOrderParams params) async {
    await orderStore.deleteOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params) async {
    final orderDataDoc =
        await orderStore.getOrderData(params.orderRef).catchError((error) {
      throw ServerException(message: error.toString());
    });

    final orderData = OrderDataModel.fromJson(
        json: orderDataDoc.data()!, orderRef: orderDataDoc.reference);
    return orderData;
  }

  @override
  Future<List<OrderItemEntity>> getOrderItems(
      GetOrderItemsParams params) async {
    final orderItemsDocs =
        await orderStore.getOrderItems(params.orderRef).catchError((error) {
      throw ServerException(message: error.toString());
    });

    final items = List<OrderItemEntity>.of(
      orderItemsDocs.docs
          .map(
            (e) => OrderItemModel.fromJson(
              json: e.data(),
              productId: e.id,
              ref: e.reference,
            ),
          )
          .toList(),
    );
    return items;
  }

  @override
  Future<List<OrderDataEntity>> getUserOrders(String userId) async {
    final ordersDataDocs =
        await orderStore.getUserOrders(userId).catchError((error) {
      throw ServerException(message: error.toString());
    });

    final ordersData = List<OrderDataEntity>.of(ordersDataDocs.docs
        .map((e) =>
            OrderDataModel.fromJson(json: e.data(), orderRef: e.reference))
        .toList());

    return ordersData;
  }

  @override
  Future<Stream<List<OrderDataEntity>>> streamOfUserOrders(
      String userId) async {
    final docsStream =
        await orderStore.streamOfUserOrders(userId).catchError((error) {
      throw ServerException(message: error.toString());
    });

    final ordersStream = docsStream.map((event) {
      return List<OrderDataEntity>.of(
        event.docs.map((e) =>
            OrderDataModel.fromJson(json: e.data(), orderRef: e.reference)),
      );
    });
    return ordersStream;
  }

  @override
  Future<Stream<List<String>>> streamUsersWhoOrdered() async {
    final idsDocsStream =
        await orderStore.streamUsersWhoOrdered().catchError((error) {
      throw ServerException(message: error.toString());
    });

    final idsStream = idsDocsStream.map((event) {
      return List<String>.of(event.docs.map((e) => e.id));
    });

    return idsStream;
  }
}

import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_item_to_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';

import '../../../../core/services/fire_store_services/order.dart';

abstract class OrderBaseRemoteDataSource {
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params);
  Future<void> addItemToOrder(AddItemToOrderParams params);
  Future<void> updateOrderData(UpDateOrderDataParams params);
  Future<void> deleteOrder(DeleteOrderParams params);
  Future<void> addOrder(AddOrderParams params);
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params);
  Future<List<OrderItemEntity>> getOrderItems(GetOrderItemsParams params);
  Future<Stream<List<UserEntity>>> streamUsersWhoOrdered();
  Future<Stream<List<OrderDataEntity>>> streamOfUserOrders(String userId);
  Future<List<OrderDataEntity>> getUserOrders(String userId);
}

class OrderRemoteDataSource implements OrderBaseRemoteDataSource {
  final OrderStore orderStore;

  OrderRemoteDataSource(this.orderStore);
  @override
  Future<void> updateOrderData(UpDateOrderDataParams params) async {
    await orderStore.updateOrderData(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> addItemToOrder(AddItemToOrderParams params) async {
    await orderStore.addItemToOrder(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> addOrder(AddOrderParams params) async {
    await orderStore.addOrder(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params) async {
    await orderStore.deleteItemFromOrder(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> deleteOrder(DeleteOrderParams params) async {
    await orderStore.deleteOrder(params.orderRef).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params) async {
    return await orderStore.getOrderData(params.orderRef).then((value) {
      return OrderDataModel.fromJson(value.data()!, orderRef: value.reference);
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<List<OrderItemEntity>> getOrderItems(GetOrderItemsParams params) async {
    return await orderStore.getOrderItems(params.orderRef).then((value) {
      return List<OrderItemEntity>.of(value.docs
          .map((e) => OrderItemModel.fromJson(json: e.data(), productId: e.id))
          .toList());
    }).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<List<OrderDataEntity>> getUserOrders(String userId) async {
    return await orderStore.getUserOrders(userId).then((value) {
      return List<OrderDataEntity>.of(value.docs
          .map((e) => OrderDataModel.fromJson(e.data(), orderRef: e.reference))
          .toList());
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<Stream<List<OrderDataEntity>>> streamOfUserOrders(
      String userId) async {
    return await orderStore.streamOfUserOrders(userId).then((stream) {
      return stream.map((event) {
        return List<OrderDataEntity>.of(event.docs.map(
            (e) => OrderDataModel.fromJson(e.data(), orderRef: e.reference)));
      });
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<Stream<List<UserEntity>>> streamUsersWhoOrdered() async {
    return await orderStore.streamUsersWhoOrdered().then((stream) {
      return stream.map((event) {
        return List<UserEntity>.of(
            event.docs.map((e) => UserModel.fromJson(e.data(), id: e.id)));
      });
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }
}

import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/user.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/order.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_data_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_items_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/add_item_to_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/up_date_order_data_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';

abstract class OrderBaseRemoteDataSource {
  Future<List<OrderItemEntity>> getOrderItems(GetOrderItemsParams params);
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params);
  Stream<List<OrderDataEntity>> streamOfUserOrders(String userId);
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params);
  Future<List<OrderDataEntity>> getUserOrders(String userId);
  Future<void> updateOrderData(UpDateOrderDataParams params);
  Future<void> addItemToOrder(AddItemToOrderParams params);
  Future<void> deleteOrder(DeleteOrderParams params);
  Stream<List<UserEntity>> streamUsersWhoOrdered();

  Future<void> addOrder(AddOrderParams params);
}

class OrderRemoteDataSource implements OrderBaseRemoteDataSource {
  final OrderStore _orderStore;
  final UserStore _userStore;

  OrderRemoteDataSource(this._orderStore, this._userStore);
  @override
  Future<void> updateOrderData(UpDateOrderDataParams params) async {
    await _orderStore.updateOrderData(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> addItemToOrder(AddItemToOrderParams params) async {
    await _orderStore.addItemToOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> addOrder(AddOrderParams params) async {
    try {
      await _orderStore.addOrder(params);
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params) async {
    await _orderStore.deleteItemFromOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> deleteOrder(DeleteOrderParams params) async {
    await _orderStore.deleteOrder(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<OrderDataEntity> getOrderData(GetOrderDataParams params) async {
    final orderDataDoc =
        await _orderStore.getOrderData(params.orderRef).catchError((error) {
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
        await _orderStore.getOrderItems(params.orderRef).catchError((error) {
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
        await _orderStore.getUserOrders(userId).catchError((error) {
      throw ServerException(message: error.toString());
    });

    final ordersData = List<OrderDataEntity>.of(ordersDataDocs.docs
        .map((e) =>
            OrderDataModel.fromJson(json: e.data(), orderRef: e.reference))
        .toList());

    return ordersData;
  }

  @override
  Stream<List<OrderDataEntity>> streamOfUserOrders(String userId) {
    final docsStream = _orderStore.streamOfUserOrders(userId);
    /*.catchError((error) {
      throw ServerException(message: error.toString());
    });*/

    final ordersStream = docsStream.map((event) {
      return List<OrderDataEntity>.of(
        event.docs.map((e) =>
            OrderDataModel.fromJson(json: e.data(), orderRef: e.reference)),
      );
    });
    return ordersStream;
  }

  @override
  Stream<List<UserEntity>> streamUsersWhoOrdered() {
    final idsStream = _streamUsersIds();
    final usersStream = _usersStream(idsStream);
    return usersStream;
  }

  Stream<List<String>> _streamUsersIds() {
    final idsDocsStream = _orderStore.streamUsersWhoOrdered();
    /*.catchError((error) {
      throw ServerException(message: error.toString());
    });*/

    final idsStream = idsDocsStream.map((event) {
      return List<String>.of(event.docs.map((e) => e.id));
    });

    return idsStream;
  }

  Stream<List<UserEntity>> _usersStream(Stream<List<String>> idsStream) async* {
    await for (List<String> ids in idsStream) {
      final users = await _getUsersData(ids);
      yield users;
    }
  }

  Future<List<UserEntity>> _getUsersData(List<String> ids) async {
    final usersDocs =
        await _userStore.getGroupUserData(ids).catchError((error) {
      throw ServerException(message: error.toString());
    });
    final users = List<UserEntity>.of(
        usersDocs.map((e) => UserModel.fromJson(e.data()!, id: e.id)).toList());
    return users;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/params/add_item_to_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/up_date_order_data_params.dart';

abstract class OrderStore {
  Future<void> addOrder(AddOrderParams params);
  Future<void> deleteOrder(DeleteOrderParams params);
  Future<void> addItemToOrder(AddItemToOrderParams params);
  Future<void> updateOrderData(UpDateOrderDataParams params);
  Future<DocumentSnapshot<Map<String, dynamic>>> getOrderData(
      DocumentReference orderRef);
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params);
  Future<QuerySnapshot<Map<String, dynamic>>> getUserOrders(String userId);
  Future<void> deleteAllOrderItems(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> items);

  ///
  Future<QuerySnapshot<Map<String, dynamic>>> getOrderItems(
      DocumentReference orderRef);
  Stream<QuerySnapshot<Map<String, dynamic>>> streamOfUserOrders(String userId);
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUsersWhoOrdered();
}

class OrderStoreImpl implements OrderStore {
  final FirebaseFirestore _store;
  final StoreHelper _storeHelper;
  OrderStoreImpl(this._store, this._storeHelper);

  /// take from this method the references of users ids;
  /// may a (new user) Order (while the admin is exploring) the Orders;
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUsersWhoOrdered() {
    final response = _store.collection(kOrders).snapshots();
    return response;
  }

  /// take from this method the references of a user orders;
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUserOrders(
      String userId) async {
    return await _store
        .collection(kOrders)
        .doc(userId)
        .collection(kOrders)
        .get();
  }

  /// may a (user) Order a new Order (while the admin is exploring) the Orders;
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> streamOfUserOrders(
      String userId) {
    return _store
        .collection(kOrders)
        .doc(userId)
        .collection(kOrders)
        .snapshots();
  }

  /// base methods (according to the design of the firebase);
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getOrderData(
      DocumentReference orderRef) async {
    return await orderRef.get() as DocumentSnapshot<Map<String, dynamic>>;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getOrderItems(
    DocumentReference orderRef,
  ) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    final response = await orderRef.collection(kItems).get();
    /*if (response.docs.isEmpty) {
      await orderRef.delete();
    }*/
    return response;
  }

  @override
  Future<void> deleteOrder(DeleteOrderParams params) async {
    /// admin and user
    /// base methods (according to the design of the firebase);

    final orderItems = await getOrderItems(params.orderRef);
    await deleteAllOrderItems(orderItems.docs);
    await params.orderRef.delete().then((value) async {
      /// delete the user if he hasn't orders...
      final orders = await getUserOrders(params.uId);
      if (orders.docs.isEmpty) {
        await params.orderRef.parent.parent!.delete();
      }
    });
  }

  @override
  Future<void> deleteAllOrderItems(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> items) async {
    for (var item in items) {
      await item.reference.delete();
    }
  }

  @override
  Future<void> updateOrderData(UpDateOrderDataParams params) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    await params.ref.set(params.data.toJson());
  }

  @override
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    await params.itemRef.delete();
    await _deleteOrderIfNoItems(params.itemRef);
  }

  Future<void> _deleteOrderIfNoItems(DocumentReference itemRef) async {
    final response = await itemRef.parent.get();
    if (response.docs.isEmpty) {
      await itemRef.parent.parent!.delete();
    }
    await _deleteUserIfNoOrders(itemRef);
  }

  Future<void> _deleteUserIfNoOrders(DocumentReference itemRef) async {
    final response = await itemRef.parent.parent!.parent.get();
    if (response.docs.isEmpty) {
      await itemRef.parent.parent!.parent.parent!.delete();
    }
  }

  @override
  Future<void> addItemToOrder(AddItemToOrderParams params) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    await params.orderRef.collection(kItems).add(params.item.toJson());
  }

  @override
  Future<void> addOrder(AddOrderParams params) async {
    final notExistedItems = await _ensureAllItemsExist(params.items);

    if (notExistedItems.isEmpty) {
      final orderRef = await _store
          .collection(kOrders)
          .doc(params.uId)
          .collection(kOrders)
          .add(params.orderData.toJson());

      await _ableToAccessOrder(params.uId);

      for (OrderItemModel item in params.items) {
        await addItemToOrder(
          AddItemToOrderParams(orderRef: orderRef, item: item),
        );
      }
    } else {
      throw ServerException(
        object: notExistedItems,
        message: AppStrings.someItemsAreOutOfStock,
      );
    }
  }

  Future<List<int>> _ensureAllItemsExist(List<OrderItemModel> items) async {
    List<int> notExisted = [];
    for (int i = 0; i < items.length; i++) {
      final isExisted = await _storeHelper.doesProductExists(
        GetProductParams(
          category: items[i].product.category,
          productId: items[i].product.id!,
        ),
      );
      if (!isExisted) {
        notExisted.add(i);
      }
    }
    return notExisted;
  }

  _ableToAccessOrder(String uId) async {
    await _store
        .collection(kOrders)
        .doc(uId)
        .set(const {"able_to_access_user_order": true});
  }
}

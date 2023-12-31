import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_item_to_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_item_from_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';

abstract class OrderStore {
  Future<void> deleteItemFromOrder(DeleteItemFromOrderParams params);
  Future<void> addItemToOrder(AddItemToOrderParams params);
  Future<void> updateOrderData(UpDateOrderDataParams params);
  Future<void> deleteOrder(DocumentReference orderRef);
  Future<void> addOrder(AddOrderParams params);
  Future<DocumentSnapshot<Map<String, dynamic>>> getOrderData(
      DocumentReference orderRef);
  Future<QuerySnapshot<Map<String, dynamic>>> getOrderItems(
      DocumentReference orderRef);
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> streamUsersWhoOrdered();
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> streamOfUserOrders(
      String userId);
  Future<QuerySnapshot<Map<String, dynamic>>> getUserOrders(String userId);
}

class OrderStoreImpl implements OrderStore {
  final FirebaseFirestore store;
  OrderStoreImpl(this.store);

  /// take from this method the references of users ids;
  /// may a (new user) Order (while the admin is exploring) the Orders;
  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      streamUsersWhoOrdered() async {
    return store.collection(FirebaseStrings.orders).snapshots();
  }

  /// take from this method the references of a user orders;
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUserOrders(
      String userId) async {
    return await store
        .collection(FirebaseStrings.orders)
        .doc(userId)
        .collection(FirebaseStrings.orders)
        .get();
  }

  /// may a (user) Order a new Order (while the admin is exploring) the Orders;
  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> streamOfUserOrders(
      String userId) async {
    return store
        .collection(FirebaseStrings.orders)
        .doc(userId)
        .collection(FirebaseStrings.orders)
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
    return await orderRef.collection(FirebaseStrings.items).get();
  }

  @override
  Future<void> deleteOrder(DocumentReference orderRef) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    await orderRef.delete();
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
    await params.orderRef
        .collection(FirebaseStrings.items)
        .doc(params.itemId)
        .delete();
  }

  @override
  Future<void> addItemToOrder(AddItemToOrderParams params) async {
    /// admin and user
    /// base methods (according to the design of the firebase);
    await params.orderRef
        .collection(FirebaseStrings.items)
        .add(params.item.toJson());
  }

  @override
  Future<void> addOrder(AddOrderParams params) async {
    await store
        .collection(FirebaseStrings.orders)
        .doc(params.uId)
        .collection(FirebaseStrings.orders)
        .add(params.orderData.toJson())
        .then((orderRef) async {
      await store
          .collection(FirebaseStrings.orders)
          .doc(params.uId)
          .set(const {"able_to_access_user_order": true});
      for (OrderItemModel item in params.items) {
        await addItemToOrder(
          AddItemToOrderParams(orderRef: orderRef, item: item),
        );
      }
    });
  }
}

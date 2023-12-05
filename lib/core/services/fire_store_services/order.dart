import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';

import '../../../modules/home/data/models/order_data_model.dart';

abstract class OrderStoreServices {
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

class UpDateOrderDataParams {
  final DocumentReference orderRef;
  final OrderDataModel orderData;

  UpDateOrderDataParams({
    required this.orderRef,
    required this.orderData,
  });
}

class AddOrderParams {
  final List<ProductModel> items;
  final OrderDataModel orderData;
  final String uId;

  AddOrderParams({
    required this.items,
    required this.orderData,
    required this.uId,
  });
}

class AddItemToOrderParams {
  final DocumentReference orderRef;
  final ProductModel item;

  AddItemToOrderParams({
    required this.orderRef,
    required this.item,
  });
}

class DeleteItemFromOrderParams {
  final DocumentReference orderRef;
  final String itemId;

  DeleteItemFromOrderParams({
    required this.orderRef,
    required this.itemId,
  });
}

class OrderStoreServicesImpl implements OrderStoreServices {
  final FirebaseFirestore store;
  OrderStoreServicesImpl(this.store);

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
    await params.orderRef.set(params.orderData.toJson());
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
      for (ProductModel item in params.items) {
        await addItemToOrder(
            AddItemToOrderParams(orderRef: orderRef, item: item));
      }
    });
  }
}

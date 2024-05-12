import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/params/edit_product_params.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/add_new_product_category_params.dart';

abstract class ProductStore {
  Stream<QuerySnapshot<Map<String, dynamic>>> loadProducts(
      LoadProductsParams params);
  Future<void> addProduct(AddProductParams product);
  Future<void> deleteProduct(DeleteProductParams params);
  Future<void> updateProduct(UpdateProductParams params);
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductCategories();
  Future<void> deleteProductCategory(DeleteProductsCategoryParams params);
  Future<void> upDateProductCategory(UpDateProductsCategoryParams params);
  Future<void> addNewProductCategory(AddNewProductsCategoryParams params);
}

class ProductStoreImpl implements ProductStore {
  final FirebaseFirestore store;

  ProductStoreImpl(this.store);

  @override
  Future<void> addProduct(AddProductParams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.product.category)
        .add(params.product.toJson());
  }

  @override
  Future<void> updateProduct(UpdateProductParams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.product.category)
        .doc(params.product.id)
        .update(params.product.toJson());
  }

  @override
  Future<void> deleteProduct(DeleteProductParams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .doc(params.productId)
        .delete();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> loadProducts(
      LoadProductsParams params) {
    return store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductCategories() {
    return store.collection(kProductCategories).snapshots();
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    await store.collection(kProductCategories).add(params.toJson());
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    await store
        .collection(kProductCategories)
        .doc(params.id)
        .update(params.toJson());
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    await store.collection(kProductCategories).doc(params.id).delete();
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.name)
        .get()
        .then((value) {
      for (var r in value.docs) {
        r.reference.delete();
      }
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';

import '../../../modules/admin/domain/use_cases/load_product_use_case.dart';

abstract class ProductStoreService {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllProductCategories();
  Future<void> deleteProduct(DeleteProductParameters parameters);
  Future<void> updateProduct(UpdateProductParameters parameters);
  Future<void> addProduct(AddProductParameters product);
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> loadProducts(
      LoadProductsParameters parameters);
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParameters parameters);
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParameters parameters);
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParameters parameters);
}

class ProductStoreServiceImpl implements ProductStoreService {
  final FirebaseFirestore store;

  ProductStoreServiceImpl(this.store);
  @override
  Future<void> addProduct(AddProductParameters product) async {
    await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(product.productCategory)
        .add(product.toJson());
  }

  @override
  Future<void> updateProduct(UpdateProductParameters parameters) async {
    await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(parameters.productCategory)
        .doc(parameters.productId)
        .update(parameters.toJson());
  }

  @override
  Future<void> deleteProduct(DeleteProductParameters parameters) async {
    await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(parameters.category)
        .doc(parameters.productId)
        .delete();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> loadProducts(
      LoadProductsParameters parameters) async {
    return store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(parameters.category)
        .snapshots();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getAllProductCategories() async {
    return store.collection(FirebaseStrings.productCategories).snapshots();
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParameters parameters) async {
    await store
        .collection(FirebaseStrings.productCategories)
        .add(parameters.toJson());
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParameters parameters) async {
    await store
        .collection(FirebaseStrings.productCategories)
        .doc(parameters.id)
        .update(parameters.toJson());
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParameters parameters) async {
    await store
        .collection(FirebaseStrings.productCategories)
        .doc(parameters.id)
        .delete();
    await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(parameters.name)
        .get()
        .then((value) {
      for (var r in value.docs) {
        r.reference.delete();
      }
    });
  }

/*Future<void> addJackets(AddProductParameters product) async {
    await store
        .collection("products")
        .doc("categories")
        .collection("jackets")
        .add(product.toJson());
  }

  Future<void> addShirts(AddProductParameters product) async {
    await store
        .collection("products")
        .doc("categories")
        .collection("shirts")
        .add(product.toJson());
  }*/
}

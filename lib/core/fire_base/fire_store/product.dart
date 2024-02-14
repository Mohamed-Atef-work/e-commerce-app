import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/load_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';

abstract class ProductStore {
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

class ProductStoreImpl implements ProductStore {
  final FirebaseFirestore store;

  ProductStoreImpl(this.store);
  @override
  Future<void> addProduct(AddProductParameters parameters) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(parameters.product.category)
        .add(parameters.product.toJson());
  }

  @override
  Future<void> updateProduct(UpdateProductParameters parameters) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(parameters.product.category)
        .doc(parameters.product.id)
        .update(parameters.product.toJson());
  }

  @override
  Future<void> deleteProduct(DeleteProductParameters parameters) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(parameters.category)
        .doc(parameters.productId)
        .delete();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> loadProducts(
      LoadProductsParameters parameters) async {
    return store
        .collection(kProducts)
        .doc(kCategories)
        .collection(parameters.category)
        .snapshots();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getAllProductCategories() async {
    return store.collection(kProductCategories).snapshots();
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParameters parameters) async {
    await store
        .collection(kProductCategories)
        .add(parameters.toJson());
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParameters parameters) async {
    await store
        .collection(kProductCategories)
        .doc(parameters.id)
        .update(parameters.toJson());
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParameters parameters) async {
    await store
        .collection(kProductCategories)
        .doc(parameters.id)
        .delete();
    await store
        .collection(kProducts)
        .doc(kCategories)
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

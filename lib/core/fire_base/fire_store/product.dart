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
  Future<void> deleteProduct(DeleteProductparams params);
  Future<void> updateProduct(UpdateProductparams params);
  Future<void> addProduct(AddProductparams product);
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> loadProducts(
      LoadProductsparams params);
  Future<void> deleteProductCategory(
      DeleteProductsCategoryparams params);
  Future<void> upDateProductCategory(
      UpDateProductsCategoryparams params);
  Future<void> addNewProductCategory(
      AddNewProductsCategoryparams params);
}

class ProductStoreImpl implements ProductStore {
  final FirebaseFirestore store;

  ProductStoreImpl(this.store);
  @override
  Future<void> addProduct(AddProductparams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.product.category)
        .add(params.product.toJson());
  }

  @override
  Future<void> updateProduct(UpdateProductparams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.product.category)
        .doc(params.product.id)
        .update(params.product.toJson());
  }

  @override
  Future<void> deleteProduct(DeleteProductparams params) async {
    await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .doc(params.productId)
        .delete();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> loadProducts(
      LoadProductsparams params) async {
    return store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .snapshots();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getAllProductCategories() async {
    return store.collection(kProductCategories).snapshots();
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryparams params) async {
    await store
        .collection(kProductCategories)
        .add(params.toJson());
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryparams params) async {
    await store
        .collection(kProductCategories)
        .doc(params.id)
        .update(params.toJson());
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryparams params) async {
    await store
        .collection(kProductCategories)
        .doc(params.id)
        .delete();
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

/*Future<void> addJackets(AddProductparams product) async {
    await store
        .collection("products")
        .doc("categories")
        .collection("jackets")
        .add(product.toJson());
  }

  Future<void> addShirts(AddProductparams product) async {
    await store
        .collection("products")
        .doc("categories")
        .collection("shirts")
        .add(product.toJson());
  }*/
}

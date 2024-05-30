import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/update_product_without_new_image_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/add_new_product_category_params.dart';

abstract class ProductStore {
  Future<String> addProduct(ProductModelParams product);
  Future<void> deleteProduct(DeleteProductParams params);
  Future<void> updateProduct(UpdateProductParams params);
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductCategories();
  Future<void> deleteProductCategory(DeleteProductsCategoryParams params);
  Future<void> upDateProductCategory(UpDateProductsCategoryParams params);
  Future<void> addNewProductCategory(AddNewProductsCategoryParams params);
  Stream<QuerySnapshot<Map<String, dynamic>>> loadProducts(
      LoadProductsParams params);
}

class ProductStoreImpl implements ProductStore {
  final FirebaseFirestore _store;
  final StoreHelper _storeHelper;

  ProductStoreImpl(this._store, this._storeHelper);

  @override
  Future<String> addProduct(ProductModelParams params) async {
    final response = await _store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.product.category)
        .add(params.product.toJson());
    return response.id;
  }

  @override
  Future<void> updateProduct(UpdateProductParams params) async {
    final existParams = GetProductParams(
        category: params.product.category, productId: params.product.id!);
    final response = await _storeHelper.doesProductExists(existParams);
    if (response) {
      await _store
          .collection(kProducts)
          .doc(kCategories)
          .collection(params.product.category)
          .doc(params.product.id)
          .update(params.product.toJson());
    } else {
      throw const ServerException(message: AppStrings.outOfStock);
    }
  }

  @override
  Future<void> deleteProduct(DeleteProductParams params) async {
    final existParams = GetProductParams(
        category: params.category, productId: params.productId);
    final response = await _storeHelper.doesProductExists(existParams);
    if (response) {
      await _store
          .collection(kProducts)
          .doc(kCategories)
          .collection(params.category)
          .doc(params.productId)
          .delete();
    } else {
      throw const ServerException(message: AppStrings.alreadyOutOfStock);
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> loadProducts(
      LoadProductsParams params) {
    return _store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductCategories() {
    return _store.collection(kProductCategories).snapshots();
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    await _store.collection(kProductCategories).add(params.toJson());
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    final oldCategory = _store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.oldName);
    final newCategory = _store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.newName);
    // ----------------------------------------------------------------

    final snapshot = await oldCategory.get();
    // ----------------------------------------------------------------

    for (var doc in snapshot.docs) {
      final data = doc.data();
      data[kId] = null;
      data[kCategory] = params.newName;
      await newCategory.add(data);
    }
    // ----------------------------------------------------------------

    for (var doc in snapshot.docs) {
      await oldCategory.doc(doc.id).delete();
    }
    // ----------------------------------------------------------------
    await _store
        .collection(kProductCategories)
        .doc(params.id)
        .update(params.toJson());
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    // ----------------------------------------------------------------
    await _store.collection(kProductCategories).doc(params.id).delete();
    // ----------------------------------------------------------------
    final result = await _store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.name)
        .get();
    // ----------------------------------------------------------------
    for (var productDoc in result.docs) {
      await productDoc.reference.delete();
    }
    // ----------------------------------------------------------------
  }
}

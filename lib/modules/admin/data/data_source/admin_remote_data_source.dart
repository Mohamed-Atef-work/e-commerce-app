import 'dart:io';
import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_storage.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import '../../domain/entities/product_category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/add_new_product_category_use_case.dart';
import '../../domain/use_cases/delete_product_category_use_case.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/edit_product_use_case.dart';
import '../../domain/use_cases/load_product_use_case.dart';
import '../../domain/use_cases/up_date_product_category_use_case.dart';

abstract class AdminBaseRemoteDataSource {
  Future<void> addProduct(AddProductparams params);
  Future<Reference> uploadProductImage(File image);
  Future<void> deleteProduct(DeleteProductParams params);
  Future<void> updateProduct(UpdateProductParams params);
  Stream<List<ProductCategoryEntity>> getAllProductCategories();
  Future<String> downLoadProductImageUrl(Reference imageReference);
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params);
  Future<void> addNewProductCategory(AddNewProductsCategoryParams params);
  Future<void> deleteProductCategory(DeleteProductsCategoryParams params);
  Future<void> upDateProductCategory(UpDateProductsCategoryParams params);
}

class AdminRemoteDataSourceImpl implements AdminBaseRemoteDataSource {
  final ProductStore store;
  final StorageService storage;

  AdminRemoteDataSourceImpl(this.store, this.storage);

  @override
  Future<String> downLoadProductImageUrl(Reference imageReference) async {
    return await storage.downloadUrl(imageReference).then((imageUrl) {
      return imageUrl;
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  @override
  Future<void> addProduct(AddProductparams params) async {
    await store.addProduct(params).then((value) {}).catchError((error) {
      return throw ServerException(
        message: error.code,
      );
    });
  }

  @override
  Future<Reference> uploadProductImage(File image) async {
    return await storage
        .uploadFile(file: image, collectionName: kProductImages)
        .then((reference) {
      return reference;
    }).catchError((error) {
      return throw ServerException(message: error.toString());
    });
  }

  @override
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params) {
    final streamOfSnaps = store.loadProducts(params);
    final streamOfModels = streamOfSnaps.map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => ProductModel.formJson(
                json: doc.data(),
                productId: doc.id,
              ),
            )
            .toList();
      },
    );
    return streamOfModels;
  }

  @override
  Future<void> deleteProduct(DeleteProductParams params) async {
    await store.deleteProduct(params).then((value) {}).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> updateProduct(UpdateProductParams params) async {
    await store.updateProduct(params).then((value) {}).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    await store
        .addNewProductCategory(params)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Stream<List<ProductCategoryEntity>> getAllProductCategories() {
    final stream = store.getAllProductCategories();
    return stream.map((snapShot) {
      return snapShot.docs
          .map((category) => ProductCategoryModel.fromJson(
                category.data(),
                id: category.id,
              ))
          .toList();
    });
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    await store
        .deleteProductCategory(params)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    await store
        .upDateProductCategory(params)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }
}

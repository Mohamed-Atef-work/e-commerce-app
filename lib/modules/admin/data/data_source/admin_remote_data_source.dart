import 'dart:io';

import 'package:e_commerce_app/modules/admin/data/model/product_category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/services/fire_storage_service.dart';
import 'package:e_commerce_app/core/services/fire_store_services/product.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
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
  Future<Stream<List<ProductCategoryEntity>>> getAllProductCategories();
  Future<String> downLoadProductImageUrl(Reference imageReference);
  Future<void> deleteProduct(DeleteProductParameters parameters);
  Future<void> updateProduct(UpdateProductParameters parameters);
  Future<void> addProduct(AddProductParameters parameters);
  Future<Stream<List<ProductEntity>>> loadProducts(
      LoadProductsParameters parameters);
  Future<Reference> uploadProductImage(File image);
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParameters parameters);
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParameters parameters);
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParameters parameters);
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
  Future<void> addProduct(AddProductParameters parameters) async {
    await store.addProduct(parameters).then((value) {}).catchError((error) {
      return throw ServerException(
        message: error.code,
      );
    });
  }

  @override
  Future<Reference> uploadProductImage(File image) async {
    return await storage
        .uploadFile(file: image, collectionName: FirebaseStrings.productImages)
        .then((reference) {
      return reference;
    }).catchError((error) {
      return throw ServerException(message: error.toString());
    });
  }

  @override
  Future<Stream<List<ProductEntity>>> loadProducts(
      LoadProductsParameters parameters) async {
    return await store.loadProducts(parameters).then((stream) {
      return stream.map((snapshot) {
        return snapshot.docs
            .map((doc) => ProductModel.formJson(
          json:doc.data(),
                  productId: doc.id,
                ))
            .toList();
      });
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> deleteProduct(DeleteProductParameters parameters) async {
    await store.deleteProduct(parameters).then((value) {}).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> updateProduct(UpdateProductParameters parameters) async {
    await store.updateProduct(parameters).then((value) {}).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParameters parameters) async {
    await store
        .addNewProductCategory(parameters)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<Stream<List<ProductCategoryEntity>>> getAllProductCategories() async {
    return await store.getAllProductCategories().then((stream) {
      return stream.map((snapShot) {
        return snapShot.docs
            .map((category) => ProductCategoryModel.fromJson(
                  category.data(),
                  id: category.id,
                ))
            .toList();
      });
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParameters parameters) async {
    await store
        .deleteProductCategory(parameters)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParameters parameters) async {
    await store
        .upDateProductCategory(parameters)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }
}

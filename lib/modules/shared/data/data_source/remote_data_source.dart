import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/fire_base/fire_storage.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_category_model.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';

abstract class SharedRemoteDataSource {
  Future<Reference> uploadImageToFireBase(File image);
  Stream<List<ProductCategoryEntity>> getAllProductCategories();
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params);
  Future<String> downLoadImageUrlFromFireBase(Reference imageReference);
}

class SharedRemoteDataSourceImpl implements SharedRemoteDataSource {
  final StorageService _storage;
  final ProductStore _store;

  SharedRemoteDataSourceImpl(this._storage, this._store);

  @override
  Future<String> downLoadImageUrlFromFireBase(Reference imageReference) async {
    return _storage
        .downloadUrl(imageReference)
        .then((imageUrl) => imageUrl)
        .catchError((error) => throw ServerException(message: error));
  }

  @override
  Future<Reference> uploadImageToFireBase(File image) async {
    return _storage
        .uploadFile(file: image, collectionName: kProductImages)
        .then((reference) => reference)
        .catchError(
            (error) => throw ServerException(message: error.toString()));
  }

  @override
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params) {
    final streamOfSnaps = _store.loadProducts(params);
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
  Stream<List<ProductCategoryEntity>> getAllProductCategories() {
    final stream = _store.getAllProductCategories();
    return stream.map((snapShot) {
      return snapShot.docs
          .map((category) => ProductCategoryModel.fromJson(
                category.data(),
                id: category.id,
              ))
          .toList();
    });
  }
}

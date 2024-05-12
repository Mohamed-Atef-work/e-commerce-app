import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';

abstract class SharedDomainRepo {
  Future<Either<Failure, File>> pickGalleryImage();
  Future<Either<Failure, bool>> deleteUserDataLocally();
  Future<Either<Failure, Reference>> uploadImage(File params);
  Future<Either<Failure, String>> downloadImageUrl(Reference params);
  Future<Either<Failure, CachedUserDataEntity>> getUserDataLocally();
  Either<Failure, Stream<List<ProductCategoryEntity>>>
      getAllProductCategories();
  Future<Either<Failure, bool>> saveUserDataLocally(
      CachedUserDataEntity cachedUser);
  Either<Failure, Stream<List<ProductEntity>>> loadProducts(
      LoadProductsParams params);
}

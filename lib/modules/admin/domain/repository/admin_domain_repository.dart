import 'dart:io';

import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepositoryDomain {
  Either<Failure, Stream<List<ProductEntity>>> loadProducts(
      LoadProductsParams params);
  Future<Either<Failure, Reference>> uploadProductImage(File params);
  Future<Either<Failure, void>> addProduct(AddProductParams params);
  Future<Either<Failure, void>> editProduct(UpdateProductParams params);
  Future<Either<Failure, String>> downloadProductImageUrl(Reference params);
  Either<Failure, Stream<List<ProductCategoryEntity>>>
      getAllProductCategories();
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParams params);
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryParams params);
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParams params);
}

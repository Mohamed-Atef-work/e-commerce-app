import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';

import '../entities/product_category_entity.dart';
import '../entities/product_entity.dart';
import '../use_cases/add_new_product_category_use_case.dart';
import '../use_cases/delete_product_category_use_case.dart';
import '../use_cases/delete_product_use_case.dart';
import '../use_cases/edit_product_use_case.dart';
import '../use_cases/load_product_use_case.dart';
import '../use_cases/up_date_product_category_use_case.dart';

abstract class AdminRepositoryDomain {
  Future<Either<Failure, Reference>> uploadProductImage(File params);
  Future<Either<Failure, void>> addProduct(AddProductparams params);
  Future<Either<Failure, void>> editProduct(UpdateProductparams params);
  Future<Either<Failure, String>> downloadProductImageUrl(Reference params);
  Future<Either<Failure, Stream<List<ProductEntity>>>> loadProducts(
      LoadProductsparams params);
  Future<Either<Failure, Stream<List<ProductCategoryEntity>>>>
      getAllProductCategories();
  Future<Either<Failure, void>> deleteProduct(
      DeleteProductparams params);
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryparams params);
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryparams params);
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryparams params);
}

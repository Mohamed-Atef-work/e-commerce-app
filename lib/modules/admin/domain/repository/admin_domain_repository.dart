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
  Future<Either<Failure, Reference>> uploadProductImage(File parameters);
  Future<Either<Failure, void>> addProduct(AddProductParameters parameters);
  Future<Either<Failure, void>> deleteProduct(
      DeleteProductParameters parameters);
  Future<Either<Failure, void>> editProduct(UpdateProductParameters parameters);
  Future<Either<Failure, String>> downloadProductImageUrl(Reference parameters);
  Future<Either<Failure, Stream<List<ProductEntity>>>> loadProducts(
      LoadProductsParameters parameters);
  Future<Either<Failure, Stream<List<ProductCategoryEntity>>>>
      getAllProductCategories();
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParameters parameters);
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryParameters parameters);
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParameters parameters);
}

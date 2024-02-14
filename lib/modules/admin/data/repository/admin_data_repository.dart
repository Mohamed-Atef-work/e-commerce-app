import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_new_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_category_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/up_date_product_category_use_case.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/edit_product_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repository/admin_domain_repository.dart';
import '../../domain/use_cases/load_product_use_case.dart';
import '../data_source/admin_remote_data_source.dart';

class AdminRepositoryData implements AdminRepositoryDomain {
  final AdminBaseRemoteDataSource dataSource;

  AdminRepositoryData(
    this.dataSource,
  );
  @override
  Future<Either<Failure, void>> addProduct(
      AddProductparams params) async {
    try {
      final result = await dataSource.addProduct(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(
        message: serverException.message,
      ));
    }
  }

  @override
  Future<Either<Failure, Reference>> uploadProductImage(File params) async {
    try {
      final result = await dataSource.uploadProductImage(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, String>> downloadProductImageUrl(
      Reference parameter) async {
    try {
      final result = await dataSource.downLoadProductImageUrl(parameter);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> loadProducts(
      LoadProductsparams params) async {
    try {
      final result = await dataSource.loadProducts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(
      DeleteProductparams params) async {
    try {
      final result = await dataSource.deleteProduct(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> editProduct(
      UpdateProductparams params) async {
    try {
      final result = await dataSource.updateProduct(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryparams params) async {
    try {
      final result = await dataSource.addNewProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<ProductCategoryEntity>>>>
      getAllProductCategories() async {
    try {
      final result = await dataSource.getAllProductCategories();
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryparams params) async {
    try {
      final result = await dataSource.deleteProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryparams params) async {
    try {
      final result = await dataSource.upDateProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}

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
      AddProductParameters parameters) async {
    try {
      final result = await dataSource.addProduct(parameters);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(
        message: serverException.message,
      ));
    }
  }

  @override
  Future<Either<Failure, Reference>> uploadProductImage(File parameters) async {
    try {
      final result = await dataSource.uploadProductImage(parameters);
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
      LoadProductsParameters parameters) async {
    try {
      final result = await dataSource.loadProducts(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(
      DeleteProductParameters parameters) async {
    try {
      final result = await dataSource.deleteProduct(parameters);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> editProduct(
      UpdateProductParameters parameters) async {
    try {
      final result = await dataSource.updateProduct(parameters);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParameters parameters) async {
    try {
      final result = await dataSource.addNewProductCategory(parameters);
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
      DeleteProductsCategoryParameters parameters) async {
    try {
      final result = await dataSource.deleteProductCategory(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParameters parameters) async {
    try {
      final result = await dataSource.upDateProductCategory(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}

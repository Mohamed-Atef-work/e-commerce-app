import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/admin/domain/params/add_new_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/edit_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repository/admin_domain_repository.dart';
import '../data_source/admin_remote_data_source.dart';

class AdminRepositoryData implements AdminRepositoryDomain {
  final AdminBaseRemoteDataSource _adminDataSource;

  AdminRepositoryData(this._adminDataSource);

  @override
  Future<Either<Failure, void>> deleteProduct(
      DeleteProductParams params) async {
    try {
      final result = await _adminDataSource.deleteProduct(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    try {
      final result = await _adminDataSource.addNewProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(AddProductParams params) async {
    try {
      final result = await _adminDataSource.addProduct(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(
        message: serverException.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    try {
      final result = await _adminDataSource.deleteProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    try {
      final result = await _adminDataSource.upDateProductCategory(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> editProduct(UpdateProductParams params) async {
    try {
      final result = await _adminDataSource.updateProduct(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}

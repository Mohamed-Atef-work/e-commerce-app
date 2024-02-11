import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';

class SharedDataRepo implements SharedDomainRepo {
  final SharedLocalDataSource _localDataSource;

  SharedDataRepo(this._localDataSource);

  @override
  Future<Either<Failure, AdminUser>> getUserOrAdminLocally() async {
    try {
      final result = await _localDataSource.getUserOrAdmin();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserDataLocally() async {
    try {
      final result = await _localDataSource.getUserData();
      print("------------- Trying -------- Repo -------- ");

      return Right(result);
    } on LocalDataBaseException catch (e) {
      print("oOoOoOops! ------- Repo ------- ${e.message}");
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getUserPasswordLocally() async {
    try {
      final result = await _localDataSource.getUserPassword();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserDataLocally() async {
    try {
      final result = await _localDataSource.deleteUserData();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserPasswordLocally() async {
    try {
      final result = await _localDataSource.deleteUserPassword();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserDataLocally(UserModel user) async {
    try {
      final result = await _localDataSource.saveUserData(user);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserPasswordLocally(String password) async {
    try {
      final result = await _localDataSource.saveUserPassword(password);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserOrAdminLocally(
      AdminUser adminUser) async {
    try {
      final result = await _localDataSource.saveUserOrAdmin(adminUser);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }
}

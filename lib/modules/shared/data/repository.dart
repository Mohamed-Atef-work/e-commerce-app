import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/shared/data/local_data_source.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';

class SharedDataRepo implements SharedDomainRepo {
  final SharedLocalDataSource _localDataSource;

  SharedDataRepo(this._localDataSource);

  @override
  Future<Either<Failure, void>> deleteUserDataLocally() async {
    try {
      final result = await _localDataSource.deleteUserData();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserPasswordLocally() async {
    try {
      final result = await _localDataSource.deleteUserPassword();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserDataLocally() async {
    try {
      final result = await _localDataSource.getUserData();
      return Right(result);
    } on LocalDataBaseException catch (e) {
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
  Future<Either<Failure, void>> saveUserDataLocally(UserModel user) async {
    try {
      final result = await _localDataSource.saveUserData(user);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserPasswordLocally(String password) async {
    try {
      final result = await _localDataSource.saveUserPassword(password);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }
}

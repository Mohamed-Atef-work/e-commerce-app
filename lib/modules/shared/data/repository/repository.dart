import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class SharedDataRepo implements SharedDomainRepo {
  final SharedLocalDataSource _localDataSource;

  SharedDataRepo(this._localDataSource);

  @override
  Future<Either<Failure, CachedUserDataEntity>> getUserDataLocally() async {
    try {
      final result = await _localDataSource.getUserData();
      print(" --------------------- DataRepo --------------------- ");

      return Right(result);
    } on LocalDataBaseException catch (e) {
      print("oOoOoOops! ------- DataRepo ------- ${e.message}");
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
  Future<Either<Failure, bool>> saveUserDataLocally(
      CachedUserDataEntity user) async {
    try {
      final cachedUser = CachedUserDataModel(
        adminOrUser: user.adminOrUser,
        userEntity: user.userEntity,
        password: user.password,
      );
      final result = await _localDataSource.saveUserData(cachedUser);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }
}

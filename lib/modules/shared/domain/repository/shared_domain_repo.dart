import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

abstract class SharedDomainRepo {
  Future<Either<Failure, bool>> deleteUserDataLocally();
  Future<Either<Failure, CachedUserDataEntity>> getUserDataLocally();
  Future<Either<Failure, bool>> saveUserDataLocally(
      CachedUserDataEntity cachedUser);
}

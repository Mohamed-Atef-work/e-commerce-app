import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

abstract class SharedDomainRepo {
  Future<Either<Failure, void>> deleteUserDataLocally();
  Future<Either<Failure, UserEntity>> getUserDataLocally();
  Future<Either<Failure, String>> getUserPasswordLocally();
  Future<Either<Failure, void>> deleteUserPasswordLocally();
  Future<Either<Failure, void>> saveUserDataLocally(UserModel user);
  Future<Either<Failure, void>> saveUserPasswordLocally(String password);
}

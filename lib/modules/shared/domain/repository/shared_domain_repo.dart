import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

abstract class SharedDomainRepo {
  Future<Either<Failure, bool>> deleteUserDataLocally();
  Future<Either<Failure, UserEntity>> getUserDataLocally();
  Future<Either<Failure, String>> getUserPasswordLocally();
  Future<Either<Failure, bool>> deleteUserPasswordLocally();
  Future<Either<Failure, AdminUser>> getUserOrAdminLocally();
  Future<Either<Failure, bool>> saveUserDataLocally(UserModel user);
  Future<Either<Failure, bool>> saveUserPasswordLocally(String password);
  Future<Either<Failure, bool>> saveUserOrAdminLocally(AdminUser adminUser);
}

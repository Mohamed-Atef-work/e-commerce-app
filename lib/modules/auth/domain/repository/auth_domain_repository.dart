import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';

abstract class AuthRepositoryDomain {
  Future<Either<Failure, void>> updateEmail(UpdateEmailParams parameters);
  Future<Either<Failure, void>> updatePassword(UpdatePasswordParams parameters);
  Future<Either<Failure, UserCredential>> signIn(LoginParameters parameters);
  Future<Either<Failure, UserCredential>> signUp(SignUpParameters parameters);
  Future<Either<Failure, void>> storeUserData(StoreUserDataParams parameters);
  Future<Either<Failure, UserEntity>> getUserData(
      GetUserDataParameters parameters);
}

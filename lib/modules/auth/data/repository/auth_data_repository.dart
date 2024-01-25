import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';

import '../../domain/use_cases/store_user_data_use_case.dart';

class AuthRepositoryData implements AuthRepositoryDomain {
  final AuthBaseRemoteDatSource authBaseRemoteDatSource;

  AuthRepositoryData(this.authBaseRemoteDatSource);

  @override
  Future<Either<Failure, UserCredential>> signIn(
      LoginParameters parameters) async {
    print(
        "<------------------- In The SignIN Data Repository ------------------->");
    try {
      final result = await authBaseRemoteDatSource.signIn(parameters);
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(
      SignUpParameters parameters) async {
    print(
        "<------------------- In The Sign_UP Data Repository ------------------->");
    try {
      final result = await authBaseRemoteDatSource.signUp(parameters);
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      return Left(
        ServerFailure(
          message: serverException.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> storeUserData(
      StoreUserDataParams parameters) async {
    try {
      final result = await authBaseRemoteDatSource.storeUserDate(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(
      GetUserDataParameters parameters) async {
    try {
      final result = await authBaseRemoteDatSource.getUserData(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}

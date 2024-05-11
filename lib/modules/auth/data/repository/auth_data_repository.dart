import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class AuthRepositoryData implements AuthRepositoryDomain {
  final AuthBaseRemoteDatSource _authDataSource;

  AuthRepositoryData(this._authDataSource);

  @override
  Future<Either<Failure, UserCredential>> signIn(LoginParams params) async {
    try {
      final result = await _authDataSource.signIn(params);
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpParams params) async {
    print(
        "<------------------- In The Sign_UP Data Repository ------------------->");
    try {
      final result = await _authDataSource.signUp(params);
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
  Future<Either<Failure, void>> storeUserData(UserEntity params) async {
    try {
      final useModel = UserModel(
        id: params.id,
        name: params.name,
        email: params.email,
        phone: params.phone,
        address: params.address,
      );
      final result = await _authDataSource.storeUserDate(useModel);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(String params) async {
    try {
      final result = await _authDataSource.getUserData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmail(UpdateEmailParams params) async {
    try {
      final result = await _authDataSource.upDateEmail(params);
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword(
      UpdatePasswordParams params) async {
    try {
      final result = await _authDataSource.upDatePassword(params);
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      print(serverException.message);
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final result = await _authDataSource.logOut();
      return Right(result);
    } on ServerException catch (serverException) {
      print(
          "<--------------------------- In The Left --------------------------->");
      print(serverException.message);
      return Left(ServerFailure(message: serverException.message));
    }
  }
}

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/local_data_source.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class SharedDataRepo implements SharedDomainRepo {
  final SharedLocalDataSource _local;
  final SharedRemoteDataSource _remote;

  SharedDataRepo(this._local, this._remote);

  @override
  Future<Either<Failure, CachedUserDataEntity>> getUserDataLocally() async {
    try {
      final result = await _local.getUserData();
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
      final result = await _local.deleteUserData();
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
      final result = await _local.saveUserData(cachedUser);
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, File>> pickGalleryImage() async {
    try {
      final result = await _local.pickGalleryImage();
      return Right(result);
    } on LocalDataBaseException catch (e) {
      return Left(LocalDataBaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Reference>> uploadImage(File params) async {
    try {
      final result = await _remote.uploadImageToFireBase(params);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }

  @override
  Future<Either<Failure, String>> downloadImageUrl(
      Reference parameter) async {
    try {
      final result = await _remote.downLoadImageUrlFromFireBase(parameter);
      return Right(result);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    }
  }
}

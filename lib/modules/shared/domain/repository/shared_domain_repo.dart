import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

abstract class SharedDomainRepo {
  Future<Either<Failure, File>> pickGalleryImage();
  Future<Either<Failure, bool>> deleteUserDataLocally();
  Future<Either<Failure, Reference>> uploadImage(File params);
  Future<Either<Failure, String>> downloadImageUrl(Reference params);
  Future<Either<Failure, CachedUserDataEntity>> getUserDataLocally();
  Future<Either<Failure, bool>> saveUserDataLocally(
      CachedUserDataEntity cachedUser);
}

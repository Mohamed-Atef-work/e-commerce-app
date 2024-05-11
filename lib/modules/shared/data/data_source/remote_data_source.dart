import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/fire_base/fire_storage.dart';

abstract class SharedRemoteDataSource {
  Future<Reference> uploadImageToFireBase(File image);
  Future<String> downLoadImageUrlFromFireBase(Reference imageReference);
}

class SharedRemoteDataSourceImpl implements SharedRemoteDataSource {
  final StorageService _storage;


  SharedRemoteDataSourceImpl(this._storage);

  @override
  Future<String> downLoadImageUrlFromFireBase(Reference imageReference) async {
    return _storage
        .downloadUrl(imageReference)
        .then((imageUrl) => imageUrl)
        .catchError((error) => throw ServerException(message: error));
  }

  @override
  Future<Reference> uploadImageToFireBase(File image) async {
    return _storage
        .uploadFile(file: image, collectionName: kProductImages)
        .then((reference) => reference)
        .catchError(
            (error) => throw ServerException(message: error.toString()));
  }
}

import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';

abstract class SharedLocalDataSource {
  Future<bool> deleteUserData();
  Future<File> pickGalleryImage();
  Future<CachedUserDataEntity> getUserData();
  Future<bool> saveUserData(CachedUserDataModel cachedUserData);
}

class SharedLocalDataSourceImpl implements SharedLocalDataSource {
  final LocalDataBaseService _localDataBaseService;

  SharedLocalDataSourceImpl(this._localDataBaseService);

  @override
  Future<CachedUserDataEntity> getUserData() async {
    try {
      final jsonString = await _localDataBaseService.read<String>(kUser);
      print(" < --------------------- dataSource ------------------------- > ");

      if (jsonString == null) {
        print(
            "--------------------- dataSource ---------------------------- > Null");
        throw const LocalDataBaseException(message: kThereIsNoData);
      }
      final userJson = jsonDecode(jsonString);
      return CachedUserDataModel.fromJson(userJson);
    } catch (e) {
      print("oOoOoOops! ----------------- dataSource ------- ${e.toString()}");
      if (e is LocalDataBaseException) {
        rethrow;
      } else {
        throw LocalDataBaseException(message: e.toString());
      }
    }
  }

  @override
  Future<bool> saveUserData(CachedUserDataModel user) async {
    final jsonString = user.toLocalJson();
    final userJson = jsonEncode(jsonString);
    final result = await _localDataBaseService
        .save<String>(kUser, userJson)
        .catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }

  @override
  Future<bool> deleteUserData() async {
    final result =
        await _localDataBaseService.delete(kUser).catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }

  @override
  Future<File> pickGalleryImage() async {
    print(
        "< --------------------- getImageFromGallery ---------------------- >");

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // A file was picked; you can use pickedFile.path to get the file path.
        // For example, you can display the image using an Image widget:
        // Image.file(File(pickedFile.path));
        // Remember to import 'dart:io'.
        return File(pickedFile.path);
      } else {
        // The user canceled the picker.
        throw const LocalDataBaseException(
            message: AppStrings.youCanceledPickingTheImage);
      }
    } catch (e) {
      throw const LocalDataBaseException(message: AppStrings.ops);
    }
  }
}

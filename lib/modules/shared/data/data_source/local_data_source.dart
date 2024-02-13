import 'dart:convert';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';

abstract class SharedLocalDataSource {
  Future<bool> deleteUserData();
  Future<CachedUserDataEntity> getUserData();
  Future<bool> saveUserData(CachedUserDataModel cachedUserData);
}

class SharedLocalDataSourceImpl implements SharedLocalDataSource {
  final LocalDataBaseService _localDataBaseService;

  SharedLocalDataSourceImpl(this._localDataBaseService);

  @override
  Future<CachedUserDataEntity> getUserData() async {
    try {
      final jsonString =
          await _localDataBaseService.read<String>(FirebaseStrings.user);
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
        .save<String>(FirebaseStrings.user, userJson)
        .catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }

  @override
  Future<bool> deleteUserData() async {
    final result = await _localDataBaseService
        .delete(FirebaseStrings.user)
        .catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }
}

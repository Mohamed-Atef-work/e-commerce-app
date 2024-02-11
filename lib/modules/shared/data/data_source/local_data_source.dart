import 'dart:convert';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

abstract class SharedLocalDataSource {
  Future<void> saveUserPassword(String password);
  Future<void> saveUserData(UserModel user);
  Future<void> deleteUserPassword();
  Future<void> deleteUserData();
  UserEntity getUserData();
  String getUserPassword();
}

class SharedLocalDataSourceImpl implements SharedLocalDataSource {
  final SharedPreferences _sharedPreferences;

  SharedLocalDataSourceImpl(this._sharedPreferences);

  @override
  UserEntity getUserData() {
    try {
      final jsonString = _sharedPreferences.getString(FirebaseStrings.user);
      if (jsonString == null) {
        throw const LocalDataBaseException(message: kThereIsNoUser);
      }
      final userJson = jsonDecode(jsonString);
      return UserModel.localJson(userJson);
    } catch (e) {
      throw (LocalDataBaseException(message: e.toString()));
    }
  }

  @override
  String getUserPassword() {
    try {
      final response =
          _sharedPreferences.getString(FirebaseStrings.userPassword);
      if (response == null) {
        throw const LocalDataBaseException(message: kThereIsNoUser);
      }
      return response;
    } catch (e) {
      throw (LocalDataBaseException(message: e.toString()));
    }
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    final jsonString = user.toJson();
    final userJson = jsonEncode(jsonString);
    await _sharedPreferences
        .setString(FirebaseStrings.user, userJson)
        .catchError((error) {
      throw (LocalDataBaseException(message: error.toString()));
    });
  }

  @override
  Future<void> deleteUserData() async {
    await _sharedPreferences.remove(FirebaseStrings.user).catchError((error) {
      throw (LocalDataBaseException(message: error.toString()));
    });
  }

  @override
  Future<void> saveUserPassword(String password) async {
    await _sharedPreferences
        .setString(FirebaseStrings.userPassword, password)
        .catchError((error) {
      throw (LocalDataBaseException(message: error.toString()));
    });
  }

  @override
  Future<void> deleteUserPassword() async {
    await _sharedPreferences
        .remove(FirebaseStrings.userPassword)
        .catchError((error) {
      throw (LocalDataBaseException(message: error.toString()));
    });
  }
}

import 'dart:convert';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

abstract class SharedLocalDataSource {
  Future<void> deleteUserData();
  Future<UserEntity> getUserData();
  Future<String> getUserPassword();
  Future<void> deleteUserPassword();
  Future<void> saveUserData(UserModel user);
  Future<void> saveUserPassword(String password);
}

class SharedLocalDataSourceImpl implements SharedLocalDataSource {
  final SharedPreferences _sharedPreferences;

  SharedLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<UserEntity> getUserData() async {
    try {
      final jsonString = _sharedPreferences.getString(FirebaseStrings.user);
      if (jsonString == null) {
        throw const LocalDataBaseException(message: "There is no user");
      }
      final userJson = jsonDecode(jsonString);
      final user = UserModel.localJson(userJson);
      return user;
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
  Future<String> getUserPassword() async {
    try {
      final response =
          _sharedPreferences.getString(FirebaseStrings.userPassword);
      if (response == null) {
        throw const LocalDataBaseException(message: "There is no user");
      }
      return response;
    } catch (e) {
      throw (LocalDataBaseException(message: e.toString()));
    }
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

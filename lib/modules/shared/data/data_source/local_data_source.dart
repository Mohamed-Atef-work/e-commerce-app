import 'dart:convert';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';

abstract class SharedLocalDataSource {
  Future<bool> deleteUserData();
  Future<UserEntity> getUserData();
  Future<String> getUserPassword();
  Future<bool> deleteUserPassword();
  Future<bool> saveUserData(UserModel user);
  Future<bool> saveUserPassword(String password);
}

class SharedLocalDataSourceImpl implements SharedLocalDataSource {
  final LocalDataBaseService _localDataBaseService;

  SharedLocalDataSourceImpl(this._localDataBaseService);

  @override
  Future<UserEntity> getUserData() async {
    try {
      final jsonString =
          await _localDataBaseService.read<String>(FirebaseStrings.user);
      print("------------- Trying -------- dataSource -------- ");

      if (jsonString == null) {
        print("------------- Trying -------- dataSource ---- Null ---- ");
        throw const LocalDataBaseException(message: kThereIsNoData);
      }
      final userJson = jsonDecode(jsonString);
      return UserModel.fromLocalJson(userJson);
    } catch (e) {
      print("oOoOoOops! ------- dataSource ------- ${e.toString()}");
      if (e is LocalDataBaseException) {
        rethrow;
      } else {
        throw LocalDataBaseException(message: e.toString());
      }
    }
  }

  @override
  Future<String> getUserPassword() async {
    try {
      final response = await _localDataBaseService
          .read<String>(FirebaseStrings.userPassword);
      if (response == null) {
        throw const LocalDataBaseException(message: kThereIsNoData);
      }
      return response;
    } catch (e) {
      print("oOoOoOops! ------- dataSource ------- ${e.toString()}");
      if (e is LocalDataBaseException) {
        rethrow;
      } else {
        throw LocalDataBaseException(message: e.toString());
      }
    }
  }

  @override
  Future<bool> saveUserData(UserModel user) async {
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

  @override
  Future<bool> saveUserPassword(String password) async {
    final result = await _localDataBaseService
        .save<String>(FirebaseStrings.userPassword, password)
        .catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }

  @override
  Future<bool> deleteUserPassword() async {
    final result = await _localDataBaseService
        .delete(FirebaseStrings.userPassword)
        .catchError((error) {
      throw LocalDataBaseException(message: error.toString());
    });
    return result;
  }
}

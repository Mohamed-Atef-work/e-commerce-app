import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';

class PrefsImpl implements LocalDataBaseService {
  late final SharedPreferences _prefs;

  PrefsImpl() {
    initializePrefs();
  }

  initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> delete(String key) async => await _prefs.remove(key);

  @override
  Future<R?> read<R>(String key) async {
    if (R is int) {
      return _prefs.getInt(key) as R?;
    } else if (R is bool) {
      return _prefs.getBool(key) as R?;
    } else if (R is double) {
      return _prefs.getDouble(key) as R?;
    } else if (R is String) {
      return _prefs.getString(key) as R?;
    } else if (R is List<String>) {
      return _prefs.getStringList(key) as R?;
    } else {
      throw const LocalDataBaseException(
          message: 'Invalid data type You want to red');
    }
  }

  @override
  Future<bool> save<T>(String key, T value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      throw const LocalDataBaseException(
          message: 'Invalid data type You want to save');
    }
  }

/*  @override
  Future<T> delete<T>(String key) async => await _prefs.remove(key);

  @override
  Future<bool> save<T, bool>(String key, T value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      throw const LocalDataBaseException(
          message: 'Invalid data type You want to save');
    }
  }

  @override
  R read<R>(String key) {
    if (R is String) {
      return _prefs.getString(key) as String;
    } else if (R is int) {
      return _prefs.getInt(key);
    } else if (R is bool) {
      return _prefs.getBool(key);
    } else if (R is double) {
      return _prefs.getDouble(key);
    } else if (R is List<String>) {
      return _prefs.getStringList(key);
    } else {
      throw const LocalDataBaseException(
          message: 'Invalid data type You want to save');
    }
  }*/
}

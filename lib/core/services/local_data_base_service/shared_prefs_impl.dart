import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/core/services/local_data_base_service/local_data_base_interface.dart';

class PrefsImpl implements LocalDataBaseService {
  final SharedPreferences _prefs;

  PrefsImpl(this._prefs);

/*  PrefsImpl() {
    initializePrefs();
  }

  PrefsImpl._(); // Private constructor

  static Future<PrefsImpl> create() async {
    var instance = PrefsImpl._();
    await instance.initializePrefs();
    return instance;
  }

  initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }*/

  @override
  Future<bool> delete(String key) async => await _prefs.remove(key);

  @override
  Future<R?> read<R>(String key) async {
    //print("------------- Trying -------- interFace -------- ");

    if (R == int) {
      return _prefs.getInt(key) as R?;
    } else if (R == bool) {
      return _prefs.getBool(key) as R?;
    } else if (R == double) {
      return _prefs.getDouble(key) as R?;
    } else if (R == String) {
      print("------------- Trying -------- interFace ---- String ---- ");

      return _prefs.getString(key) as R?;
    } else if (R == List<String>) {
      return _prefs.getStringList(key) as R?;
    } else {
      print("oOoOoOops! ------- interFace ------- ");
      throw Exception('Invalid data type You want to read');
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
      throw Exception('Invalid data type You want to save');
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

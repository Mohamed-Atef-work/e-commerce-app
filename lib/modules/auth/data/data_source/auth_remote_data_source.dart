import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/user.dart';
import 'package:e_commerce_app/core/fire_base/fire_auth/user_auth.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';

abstract class AuthBaseRemoteDatSource {
  Future<UserCredential> signIn(LoginParameters parameters);
  Future<UserCredential> signUp(SignUpParameters parameters);
  Future<void> storeUserDate(StoreUserDataParams parameters);
  Future<UserEntity> getUserData(GetUserDataParameters parameters);
  Future<void> upDatePassword(UpdatePasswordParams parameters);
  Future<void> upDateEmail(UpdateEmailParams parameters);
}

/// <-------------------------------------------------------------------------->
class AuthRemoteDatSourceImpl implements AuthBaseRemoteDatSource {
  final UserStore _userStore;
  final UserAuth _userAuth;

  AuthRemoteDatSourceImpl(this._userStore, this._userAuth);

  @override
  Future<void> upDatePassword(UpdatePasswordParams parameters) async {
    try {
      await _userAuth.reAuthenticateWithCredential(parameters.currentPassword);
      await _userAuth.upDataPassword(parameters.newPassword);
    } catch (error) {
      throw (ServerException(message: error.toString()));
    }
  }

  @override
  Future<void> upDateEmail(UpdateEmailParams parameters) async {
    try {
      await _userAuth.reAuthenticateWithCredential(parameters.password);
      await _userAuth.upDataEmail(parameters.email);
    } catch (error) {
      throw (ServerException(message: error.toString()));
    }
  }

  @override
  Future<UserCredential> signIn(LoginParameters parameters) async {
    print(
        "<----------------- In The SIGN_IN Remote Data Source ------------------>");
    final userCredential = _userAuth.signIn(parameters).catchError((error) {
      throw (ServerException(message: error.code));
    });
    return userCredential;
  }

  @override
  Future<UserCredential> signUp(SignUpParameters parameters) async {
    print(
        "<----------------- In The SIGN_UP Remote Data Source ------------------>");
    final userCredential = _userAuth.signUp(parameters).catchError((error) {
      throw ServerException(message: error.code);
    });
    return userCredential;
  }

  @override
  Future<void> storeUserDate(StoreUserDataParams parameters) async {
    await _userStore
        .storeUserData(parameters)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<UserEntity> getUserData(parameters) async {
    final userDoc =
        await _userStore.getUserData(parameters.uId).catchError((error) {
      throw ServerException(message: error.code);
    });
    final user = UserModel.fromJson(userDoc.data()!, id: userDoc.id);

    return user;
  }
}

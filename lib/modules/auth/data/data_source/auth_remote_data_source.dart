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
  Future<UserCredential> signIn(Loginparams params);
  Future<UserCredential> signUp(SignUpparams params);
  Future<void> storeUserDate(StoreUserDataParams params);
  Future<UserEntity> getUserData(GetUserDataparams params);
  Future<void> upDatePassword(UpdatePasswordParams params);
  Future<void> upDateEmail(UpdateEmailParams params);
}

/// <-------------------------------------------------------------------------->
class AuthRemoteDatSourceImpl implements AuthBaseRemoteDatSource {
  final UserStore _userStore;
  final UserAuth _userAuth;

  AuthRemoteDatSourceImpl(this._userStore, this._userAuth);

  @override
  Future<void> upDatePassword(UpdatePasswordParams params) async {
    try {
      await _userAuth.reAuthenticateWithCredential(params.currentPassword);
      await _userAuth.upDataPassword(params.newPassword);
    } catch (error) {
      throw (ServerException(message: error.toString()));
    }
  }

  @override
  Future<void> upDateEmail(UpdateEmailParams params) async {
    try {
      await _userAuth.reAuthenticateWithCredential(params.password);
      await _userAuth.upDataEmail(params.email);
    } catch (error) {
      throw (ServerException(message: error.toString()));
    }
  }

  @override
  Future<UserCredential> signIn(Loginparams params) async {
    print(
        "<----------------- In The SIGN_IN Remote Data Source ------------------>");
    final userCredential = _userAuth.signIn(params).catchError((error) {
      throw (ServerException(message: error.code));
    });
    return userCredential;
  }

  @override
  Future<UserCredential> signUp(SignUpparams params) async {
    print(
        "<----------------- In The SIGN_UP Remote Data Source ------------------>");
    final userCredential = _userAuth.signUp(params).catchError((error) {
      throw ServerException(message: error.code);
    });
    return userCredential;
  }

  @override
  Future<void> storeUserDate(StoreUserDataParams params) async {
    await _userStore
        .storeUserData(params)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<UserEntity> getUserData(params) async {
    final userDoc =
        await _userStore.getUserData(params.uId).catchError((error) {
      throw ServerException(message: error.code);
    });
    final user = UserModel.fromJson(userDoc.data()!, id: userDoc.id);

    return user;
  }
}

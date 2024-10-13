import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/user.dart';
import 'package:e_commerce_app/core/fire_base/fire_auth/user_auth.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_params.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_password_params.dart';
import 'package:flutter/services.dart';

abstract class AuthBaseRemoteDatSource {
  Future<void> logOut();
  Future<void> storeUserDate(UserModel user);
  Future<UserEntity> getUserData(String uId);
  Future<UserCredential> signIn(LoginParams params);
  Future<UserCredential> signUp(SignUpParams params);
  Future<void> upDateEmail(UpdateEmailParams params);
  Future<void> upDatePassword(UpdatePasswordParams params);
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
    } on FirebaseAuthException catch (exc) {
      final serverExc = ServerException.fromFirebaseAuthException(exc);
      throw serverExc;
    } catch (exc) {
      final serverExc = ServerException(message: exc.toString());
      throw serverExc;
    }
  }

  @override
  Future<void> upDateEmail(UpdateEmailParams params) async {
    try {
      await _userAuth.reAuthenticateWithCredential(params.password);
      await _userAuth.upDataEmail(params.newEmail);
    } catch (error) {
      throw (ServerException(message: error.toString()));
    }
  }

  @override
  Future<UserCredential> signIn(LoginParams params) async {
    print(
        "<----------------- In The SIGN_IN Remote Data Source ------------------>");
    try {
      final userCredential = await _userAuth.signIn(params);
      return userCredential;
    } on FirebaseAuthException catch (exc) {
      final serverExc = ServerException.fromFirebaseAuthException(exc);
      throw serverExc;
    } on FirebaseException catch (exc) {
      final serverExc = ServerException.fromFirebaseException(exc);
      throw serverExc;
    } on PlatformException catch (exc) {
      final serverExc = ServerException.fromPlatformException(exc);
      throw serverExc;
    } catch (e) {
      print("ERROR is -------> ${e.toString()}");
      throw (ServerException(message: e.toString()));
    }
  }

  @override
  Future<UserCredential> signUp(SignUpParams params) async {
    print(
        "<----------------- In The SIGN_UP Remote Data Source ------------------>");
    final userCredential = _userAuth.signUp(params).catchError((error) {
      throw ServerException(message: error.code);
    });
    return userCredential;
  }

  @override
  Future<void> storeUserDate(UserModel user) async =>
      await _userStore.storeUserData(user).then((_) {}).catchError((error) {
        throw ServerException(message: error.code);
      });

  @override
  Future<UserEntity> getUserData(String uId) async {
    final userDoc = await _userStore.getUserData(uId).catchError((error) {
      throw ServerException(message: error.code);
    });
    final user = UserModel.fromJson(userDoc.data()!, id: userDoc.id);
    return user;
  }

  @override
  Future<void> logOut() async {
    try {
      await _userAuth.logOut();
    } catch (exception) {
      throw ServerException(message: exception.toString());
    }
  }
}

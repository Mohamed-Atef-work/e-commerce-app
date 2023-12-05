import 'package:e_commerce_app/core/services/fire_store_services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';

import '../../domain/use_cases/store_user_data_use_case.dart';

abstract class AuthBaseRemoteDatSource {
  Future<UserCredential> signIn(LoginParameters parameters);
  Future<UserCredential> signUp(SignUpParameters parameters);
  Future<void> storeUserDate(StoreUserDataParameters parameters);
}

/// <-------------------------------------------------------------------------->
class AuthRemoteDatSourceImpl implements AuthBaseRemoteDatSource {
  final UserStoreServices userStore;

  AuthRemoteDatSourceImpl(this.userStore);
  @override
  Future<UserCredential> signIn(LoginParameters parameters) async {
    print(
        "<----------------- In The SIGN_IN Remote Data Source ------------------>");
    final response = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: parameters.email,
          password: parameters.password,
        )
        .then((userCredential) => userCredential)
        .catchError((error) {
      throw (ServerException(message: error.code));
    });
    return response;
  }

  @override
  Future<UserCredential> signUp(SignUpParameters parameters) async {
    print(
        "<----------------- In The SIGN_UP Remote Data Source ------------------>");
    final response = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: parameters.email,
          password: parameters.password,
        )
        .then((userCredential) => userCredential)
        .catchError((error) {
      throw ServerException(message: error.code);
    });
    return response;
  }

  @override
  Future<void> storeUserDate(StoreUserDataParameters parameters) async {
    await userStore
        .storeUserData(parameters)
        .then((value) {})
        .catchError((error) {
      throw ServerException(message: error.code);
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_params.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/sign_up_use_case.dart';

abstract class UserAuth {
  Future<void> logOut();
  Future<void> upDataEmail(String newEmail);
  Future<void> upDataPassword(String newPassword);
  Future<UserCredential> signIn(LoginParams params);
  Future<UserCredential> signUp(SignUpParams params);
  Future<void> reAuthenticateWithCredential(String currentPassword);
}

class UserAuthImpl implements UserAuth {
  final FirebaseAuth _auth;
  UserAuthImpl(this._auth);

  @override
  Future<void> reAuthenticateWithCredential(String currentPassword) async {
    final User user = _auth.currentUser!;
    final credential = EmailAuthProvider.credential(
      password: currentPassword,
      email: user.email!,
    );
    await user.reauthenticateWithCredential(credential);
  }

  @override
  Future<void> upDataPassword(String newPassword) async {
    final User user = _auth.currentUser!;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> upDataEmail(String newEmail) async {
    final User user = _auth.currentUser!;
    await user.updateEmail(newEmail);
  }

  @override
  Future<UserCredential> signIn(LoginParams params) async =>
      await _auth.signInWithEmailAndPassword(
        password: params.password,
        email: params.email,
      );

  @override
  Future<UserCredential> signUp(SignUpParams params) async =>
      await _auth.createUserWithEmailAndPassword(
        password: params.password,
        email: params.email,
      );

  @override
  Future<void> logOut() async => await _auth.signOut();
}

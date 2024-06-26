import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';

abstract class UserStore {
  Future<void> storeUserData(UserModel user);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uId);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getGroupUserData(
      List<String> ids);
}

class UserStoreImpl implements UserStore {
  final FirebaseFirestore store;

  UserStoreImpl(this.store);

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uId) async {
    return await store.collection(kUsers).doc(uId).get();
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getGroupUserData(
      List<String> ids) async {
    List<DocumentSnapshot<Map<String, dynamic>>> users = [];
    for (String uId in ids) {
      await getUserData(uId).then((userDoc) {
        users.add(userDoc);
      });
    }
    return users;
  }

  @override
  Future<void> storeUserData(UserModel user) async {
    await store.collection(kUsers).doc(user.id).set(user.toJson());
  }
}

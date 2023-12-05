import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';

import '../../../modules/auth/domain/use_cases/store_user_data_use_case.dart';

abstract class UserStoreServices {
  Future<void> storeUserData(StoreUserDataParameters params);
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uId);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getGroupUserData(
      List<String> ids);
}

class UserStoreServicesImpl implements UserStoreServices {
  final FirebaseFirestore store;

  UserStoreServicesImpl(this.store);
  @override
  Future<void> storeUserData(StoreUserDataParameters params) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(params.id)
        .set(params.toJson());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uId) async {
    return await store.collection(FirebaseStrings.users).doc(uId).get();
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
}

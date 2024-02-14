import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SharedUserDataEntity {
  final UserCredential userCredential;
  final CachedUserDataEntity user;

  SharedUserDataEntity({
    required this.userCredential,
    required this.user,
  });
}

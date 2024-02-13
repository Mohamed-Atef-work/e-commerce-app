import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitEntity {
  final UserCredential userCredential;
  final CachedUserDataEntity user;

  InitEntity({
    required this.userCredential,
    required this.user,
  });
}

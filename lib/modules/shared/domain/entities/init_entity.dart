import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitEntity {
  final UserCredential userCredential;
  final UserEntity userEntity;
  final AdminUser adminUser;

  InitEntity({
    required this.userCredential,
    required this.userEntity,
    required this.adminUser,
  });
}

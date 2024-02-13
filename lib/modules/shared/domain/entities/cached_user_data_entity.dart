import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

class CachedUserDataEntity {
  final String password;
  final UserEntity userEntity;
  final AdminUser adminOrUser;

  CachedUserDataEntity({
    required this.password,
    required this.userEntity,
    required this.adminOrUser,
  });
}

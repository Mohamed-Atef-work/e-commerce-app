import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class CachedUserDataModel extends CachedUserDataEntity {
  CachedUserDataModel({
    required super.password,
    required super.userEntity,
    required super.adminOrUser,
  });
  factory CachedUserDataModel.fromJson(Map<String, dynamic> json) =>
      CachedUserDataModel(
        userEntity: UserEntity(
          id: json[FirebaseStrings.id],
          name: json[FirebaseStrings.name],
          email: json[FirebaseStrings.email],
          phone: json[FirebaseStrings.phone],
          address: json[FirebaseStrings.address],
        ),
        password: json[FirebaseStrings.userPassword],
        adminOrUser: json[FirebaseStrings.userOrAdmin] == FirebaseStrings.user
            ? AdminUser.user
            : AdminUser.admin,
      );

  Map<String, String?> toLocalJson() => {
        FirebaseStrings.id: userEntity.id,
        FirebaseStrings.name: userEntity.name,
        FirebaseStrings.userPassword: password,
        FirebaseStrings.email: userEntity.email,
        FirebaseStrings.phone: userEntity.phone,
        FirebaseStrings.address: userEntity.address,
        FirebaseStrings.userOrAdmin: adminOrUser == AdminUser.user
            ? FirebaseStrings.user
            : FirebaseStrings.admin,
      };
}

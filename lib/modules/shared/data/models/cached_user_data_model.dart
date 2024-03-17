import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
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
          id: json[kId],
          name: json[kName],
          email: json[kEmail],
          phone: json[kPhone],
          address: json[kAddress],
        ),
        password: json[kUserPassword],
        adminOrUser:
            json[kUserOrAdmin] == kUser ? AdminUser.user : AdminUser.admin,
      );

  Map<String, String?> toLocalJson() => {
        kId: userEntity.id,
        kName: userEntity.name,
        kUserPassword: password,
        kEmail: userEntity.email,
        kPhone: userEntity.phone,
        kAddress: userEntity.address,
        kUserOrAdmin: adminOrUser == AdminUser.user ? kUser : kAdmin,
      };
}

import 'package:e_commerce_app/core/fire_base/strings.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.address,
  });
  factory UserModel.fromJson(Map<String, dynamic> json, {required String id}) =>
      UserModel(
        id: id,
        name: json[FirebaseStrings.name],
        email: json[FirebaseStrings.email],
        phone: json[FirebaseStrings.phone],
        address: json[FirebaseStrings.address],
      );
  Map<String, dynamic> toJson() => {
        FirebaseStrings.name: name,
        FirebaseStrings.email: email,
        FirebaseStrings.phone: phone,
        FirebaseStrings.address: address,
      };

}

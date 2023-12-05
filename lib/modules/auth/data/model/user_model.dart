import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.address,
  });
  factory UserModel.fromJson(Map<String, dynamic> json, {required String id}) =>
      UserModel(
        id: id,
        name: json["name"],
        email: json["email"],
        phone: json["phone"] ?? "",
        address: json["address"] ?? "",
      );
}

import 'package:e_commerce_app/core/constants/strings.dart';
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
        name: json[kName],
        email: json[kEmail],
        phone: json[kPhone],
        address: json[kAddress],
      );
  Map<String, dynamic> toJson() => {
        kName: name,
        kEmail: email,
        kPhone: phone,
        kAddress: address,
      };
}

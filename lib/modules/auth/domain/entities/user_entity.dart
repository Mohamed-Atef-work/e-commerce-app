import 'package:e_commerce_app/core/utils/enums.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final AdminUser? userOrAdmin;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.userOrAdmin,
    this.address,
    this.phone,
  });
}

import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/utils/enums.dart';

class LoginParams extends Equatable {
  final String email, password;
  final AdminUser adminOrUser;
  const LoginParams({
    required this.adminOrUser,
    required this.password,
    required this.email,
  });
  @override
  List<Object?> get props => [
        email,
        password,
        adminOrUser,
      ];
}

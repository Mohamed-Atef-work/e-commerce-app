import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();
}

class SignInEvent extends LoginEvents {
  final AdminUser adminOrUser;
  const SignInEvent(this.adminOrUser);
  @override
  List<Object?> get props => [adminOrUser];
}

class ObSecureEvent extends LoginEvents {
  const ObSecureEvent();
  @override
  List<Object?> get props => [];
}

class ToggleAdminAndUserEvent extends LoginEvents {
  const ToggleAdminAndUserEvent();
  @override
  List<Object?> get props => [];
}

class RebuildEvent extends LoginEvents {
  const RebuildEvent();
  @override
  List<Object?> get props => [];
}

/*class SaveUserDataEvent extends LoginEvents {
  final CachedUserDataModel user;
  const SaveUserDataEvent(this.user);
  @override
  List<Object?> get props => [];
}*/

/*class TakePasswordEvent extends LoginEvents {
  final String password;

  const TakePasswordEvent({
    required this.password,
  });
  @override
  List<Object?> get props => [
        password,
      ];
}

class TakeEmailEvent extends LoginEvents {
  final String email;

  const TakeEmailEvent({
    required this.email,
  });
  @override
  List<Object?> get props => [
        email,
      ];
}*/

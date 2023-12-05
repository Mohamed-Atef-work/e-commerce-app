import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();
}

class SignInEvent extends LoginEvents {
  const SignInEvent();
  @override
  List<Object?> get props => [];
}

class ToggleAdminAndUserEvent extends LoginEvents {
  const ToggleAdminAndUserEvent();
  @override
  List<Object?> get props => [];
}

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

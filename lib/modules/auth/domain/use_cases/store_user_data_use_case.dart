import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class StoreUserDataUseCase extends BaseUseCase<void, UserModel> {
  final AuthRepositoryDomain domain;

  StoreUserDataUseCase(this.domain);
  @override
  Future<Either<Failure, void>> call(UserModel params) async {
    return await domain.storeUserData(params);
  }
}

class StoreUserDataParams {
  final UserModel userModel;

  StoreUserDataParams({required this.userModel});
}

/*class StoreUserDataParams extends Equatable {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String id;

  const StoreUserDataParams({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.id,
  });

  Map<String, String> toJson() => {
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "id": id,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        address,
        phone,
        id,
      ];
}*/

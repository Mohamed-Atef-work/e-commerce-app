import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class SignUpUseCase extends BaseUseCase<UserCredential, SignUpParams> {
  final AuthRepositoryDomain domainRepository;

  SignUpUseCase(this.domainRepository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {

    final result = await domainRepository.signUp(params);
    result.fold((l) {

    }, (r) {

    });
    return result;
  }
}

class SignUpParams {
  final String name, email, password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

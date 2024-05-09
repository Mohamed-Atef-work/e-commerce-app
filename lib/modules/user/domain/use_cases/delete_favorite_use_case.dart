import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/add_favorite_use_case.dart';

class DeleteFavoriteUseCase extends BaseUseCase<void, AddDeleteFavoriteParams> {
  final FavoriteDomainRepository repo;

  DeleteFavoriteUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddDeleteFavoriteParams params) async {
    return await repo.deleteFavorite(params);
  }
}

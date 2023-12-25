import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/repository/favorite_domain_repository.dart';

class GetFavoritesUseCase
    extends BaseUseCase<List<FavoriteEntity>, GetFavoritesParams> {
  final FavoriteDomainRepository domainRepository;

  GetFavoritesUseCase(this.domainRepository);
  @override
  Future<Either<Failure, List<FavoriteEntity>>> call(
      GetFavoritesParams parameters) async {
    return await domainRepository.getFavorites(parameters);
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:equatable/equatable.dart';

class GetFavoritesUseCase
    extends BaseUseCase<List<FavoriteEntity>, GetFavoritesParams> {
  final FavoriteDomainRepository domainRepository;

  GetFavoritesUseCase(this.domainRepository);
  @override
  Future<Either<Failure, List<FavoriteEntity>>> call(
      GetFavoritesParams params) async {
    return await domainRepository.getFavorites(params);
  }
}

class GetFavoritesParams extends Equatable {
  final String uId;

  const GetFavoritesParams({required this.uId});

  @override
  List<Object?> get props => [
        uId,
      ];
}

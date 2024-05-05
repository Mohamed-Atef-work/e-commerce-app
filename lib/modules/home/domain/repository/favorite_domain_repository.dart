import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';

abstract class FavoriteDomainRepository {
  Future<Either<Failure, void>> addFavorite(AddDeleteFavoriteParams params);
  Future<Either<Failure, void>> deleteFavorite(AddDeleteFavoriteParams params);
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(
      GetFavoritesParams params);
}

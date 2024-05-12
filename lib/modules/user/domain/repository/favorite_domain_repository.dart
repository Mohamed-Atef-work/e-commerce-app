import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';
import 'package:e_commerce_app/modules/user/domain/params/get_favorites_params.dart';

abstract class FavoriteDomainRepository {
  Future<Either<Failure, void>> addFavorite(AddDeleteFavoriteParams params);
  Future<Either<Failure, void>> deleteFavorite(AddDeleteFavoriteParams params);
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(
      GetFavoritesParams params);
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_category_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteDomainRepository {
  Future<Either<Failure, void>> addFavorite(AddDeleteFavoriteParams parameters);
  Future<Either<Failure, void>> deleteFavorite(
      AddDeleteFavoriteParams parameters);
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(
      GetFavoritesParams parameters);
//Future<Either<Failure, FavoriteEntity>> getFavOfOneCategory(GetFavOfOneCategoryParams parameters);
}

/// < ======================================================================== >

class GetFavOfOneCategoryParams extends Equatable {
  final FavoriteCategoryEntity category;

  const GetFavOfOneCategoryParams({
    required this.category,
  });

  @override
  List<Object?> get props => [
        category,
      ];
}

class GetFavCategoriesParams extends Equatable {
  final String uId;

  const GetFavCategoriesParams({required this.uId});

  @override
  List<Object?> get props => [
        uId,
      ];
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_categories_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteDomainRepository {
  Future<Either<Failure, void>> addFavorite(AddFavoriteParams parameters);
  Future<Either<Failure, List<FavoriteCategoryEntity>>> getFavCategories(
      GetFavCategoriesParams parameters);
  Future<Either<Failure, FavoriteEntity>> getFavOfOneCategory(
      GetFavOfOneCategoryParams parameters);
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(
      GetFavoritesParams parameters);
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

class AddFavoriteParams extends Equatable {
  final String category;
  final String productId;
  final String uId;

  const AddFavoriteParams({
    required this.category,
    required this.productId,
    required this.uId,
  });

  @override
  List<Object?> get props => [
        uId,
        category,
        productId,
      ];
}

class GetFavoritesParams extends Equatable {
  final String uId;

  const GetFavoritesParams({required this.uId});

  @override
  List<Object?> get props => [
        uId,
      ];
}

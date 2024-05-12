import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';
import 'package:e_commerce_app/modules/user/domain/params/get_favorites_params.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/user/data/data_source/favorite_remote_data_source.dart';

class FavoriteDataRepository implements FavoriteDomainRepository {
  final FavoriteBaseRemoteDataSource dataSource;

  FavoriteDataRepository(this.dataSource);

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites(
      GetFavoritesParams params) async {
    try {
      final result = await dataSource.getFavorites(params.uId);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(
      AddDeleteFavoriteParams params) async {
    try {
      final result = await dataSource.addFav(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavorite(
      AddDeleteFavoriteParams params) async {
    try {
      final result = await dataSource.deleteFav(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

/*  @override
  Future<Either<Failure, FavoriteEntity>> getFavOfOneCategory(
      GetFavOfOneCategoryParams params) async {
    try {
      final result = await dataSource.getFavOfOneCategory(params.category);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }*/
}

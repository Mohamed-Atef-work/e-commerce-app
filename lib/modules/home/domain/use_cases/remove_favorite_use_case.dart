import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/favorite_domain_repository.dart';
import 'package:equatable/equatable.dart';

class RemoveFavoriteUseCase extends BaseUseCase<void, AddFavoriteParams> {
  final FavoriteDomainRepository repo;

  RemoveFavoriteUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddFavoriteParams parameters) async {
    //return await repo.addFavorite(parameters);
  }
}
class DeleteFavoriteParams extends Equatable {
  final String category;
  final String productId;
  final String uId;

  const DeleteFavoriteParams({
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

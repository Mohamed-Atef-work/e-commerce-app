import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domin_repository.dart';

class CartDataRepo implements CartDomainRepo{
  final CartBaseRemoteDataSource dataSource;

  CartDataRepo(this.dataSource);
  @override
  Future<Either<Failure, void>> addToCart(CartParams params) async{
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteFromCart(CartParams params) async{
    // TODO: implement deleteFromCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductCategoryEntity>>> getCartCategories(String uId) async{
    // TODO: implement getCartCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getCartProducts(String uId) async{
    // TODO: implement getCartProducts
    throw UnimplementedError();
  }


  @override
  Future<Either<Failure, ProductEntity>> getProduct(GetProductParams params) async{
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsOfCategory(GetProductsOfOneCategoryParams params) async{
    // TODO: implement getProductsOfCategory
    throw UnimplementedError();
  }
}
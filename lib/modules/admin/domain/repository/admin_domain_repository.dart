import 'package:e_commerce_app/modules/admin/domain/params/add_new_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/edit_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepositoryDomain {
  Either<Failure, Stream<List<ProductEntity>>> loadProducts(
      LoadProductsParams params);
  Future<Either<Failure, void>> addProduct(AddProductParams params);

  Either<Failure, Stream<List<ProductCategoryEntity>>>
      getAllProductCategories();
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParams params);
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryParams params);
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParams params);
  Future<Either<Failure, void>> editProduct(UpdateProductParams params);
}

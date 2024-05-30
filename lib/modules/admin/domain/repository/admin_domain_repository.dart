import 'package:e_commerce_app/modules/admin/domain/use_cases/update_product_without_new_image_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/params/add_new_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/up_date_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_category_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/core/error/failure.dart';

import 'package:dartz/dartz.dart';

abstract class AdminRepositoryDomain {
  Future<Either<Failure, String>> addProduct(ProductModelParams params);
  Future<Either<Failure, void>> editProduct(UpdateProductParams params);
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
  Future<Either<Failure, ProductEntity>> getProduct(GetProductParams params);
  Future<Either<Failure, void>> addNewProductCategory(
      AddNewProductsCategoryParams params);
  Future<Either<Failure, void>> deleteProductCategory(
      DeleteProductsCategoryParams params);
  Future<Either<Failure, void>> upDateProductCategory(
      UpDateProductsCategoryParams params);
}

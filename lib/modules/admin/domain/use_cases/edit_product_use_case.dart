import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class UpdateProductUseCase extends BaseUseCase<void, UpdateProductParameters> {
  final AdminRepositoryDomain domain;

  UpdateProductUseCase(this.domain);
  @override
  Future<Either<Failure, void>> call(UpdateProductParameters parameters) async {
    return await domain.editProduct(parameters);
  }
}

class UpdateProductParameters {
  final ProductModel product;

  const UpdateProductParameters({required this.product});
}

/*class UpdateProductParameterss {
  final String productDescription;
  final String productLocation;
  final String productCategory;
  final String productPrice;
  final String productImage;
  final String productName;
  final String productId;

  const UpdateProductParameterss({
    required this.productDescription,
    required this.productLocation,
    required this.productCategory,
    required this.productPrice,
    required this.productImage,
    required this.productName,
    required this.productId,
  });

  Map<String, String> toJson() => {
        "productDescription": productDescription,
        "productLocation": productLocation,
        "productCategory": productCategory,
        "productImage": productImage,
        "productPrice": productPrice,
        "productName": productName,
      };
}*/

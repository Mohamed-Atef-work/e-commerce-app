import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class AddProductUseCase extends BaseUseCase<void, AddProductParameters> {
  final AdminRepositoryDomain domainRepository;

  AddProductUseCase(
    this.domainRepository,
  );

  @override
  Future<Either<Failure, void>> call(AddProductParameters parameters) async {
    return await domainRepository.addProduct(parameters);
  }
}

class AddProductParameters {
  final String productDescription;
  final String productLocation;
  final String productCategory;
  final String productPrice;
  final String productImage;
  final String productName;

  const AddProductParameters({
    required this.productDescription,
    required this.productLocation,
    required this.productCategory,
    required this.productPrice,
    required this.productImage,
    required this.productName,
  });

  Map<String, String> toJson() => {
        "productName": productName,
        "productPrice": productPrice,
        "productDescription": productDescription,
        "productCategory": productCategory,
        "productImage": productImage,
        "productLocation": productLocation,
      };
}

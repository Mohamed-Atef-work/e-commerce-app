import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:equatable/equatable.dart';

class UpDateOrderDataUseCase extends BaseUseCase<void, UpDateOrderDataParams> {
  final OrderDomainRepo repo;

  UpDateOrderDataUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(UpDateOrderDataParams parameters) async {
    final result = await repo.updateOrderData(parameters);
    return result;
  }
}

class UpDateOrderDataParams extends Equatable {
  final DocumentReference ref;
  final OrderDataModel data;

  const UpDateOrderDataParams({
    required this.ref,
    required this.data,
  });

  @override
  List<Object?> get props => [
        ref,
        data,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class AdminDetailsState extends Equatable {
  final String? message;
  final ProductEntity? product;
  final RequestState? deleteState;

  const AdminDetailsState({
    this.product,
    this.message = "",
    this.deleteState = RequestState.initial,
  });
  AdminDetailsState copyWith({
    String? message,
    ProductEntity? product,
    RequestState? deleteState,
  }) =>
      AdminDetailsState(
        message: message ?? this.message,
        product: product ?? this.product,
        deleteState: deleteState ?? this.deleteState,
      );

  @override
  List<Object?> get props => [
        product,
        message,
        deleteState,
      ];
}

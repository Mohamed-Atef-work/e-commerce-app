import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class AdminDetailsState extends Equatable {
  final String? message;
  final ProductEntity? product;
  final RequestState? deleteState;
  final RequestState? getState;

  const AdminDetailsState({
    this.product,
    this.message = "",
    this.getState = RequestState.success,
    this.deleteState = RequestState.initial,
  });
  AdminDetailsState copyWith({
    String? message,
    ProductEntity? product,
    RequestState? getState,
    RequestState? deleteState,
  }) =>
      AdminDetailsState(
        message: message ?? this.message,
        product: product ?? this.product,
        getState: getState ?? this.getState,
        deleteState: deleteState ?? this.deleteState,
      );

  @override
  List<Object?> get props => [
        product,
        message,
        getState,
        deleteState,
      ];
}

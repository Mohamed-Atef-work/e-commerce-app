import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';
import '../../../domain/entities/product_entity.dart';

class AdminDetailsState extends Equatable {
  final ProductEntity? selectedProduct;
  final List<ProductEntity>? products;
  final RequestState? deleteState;
  final RequestState? productsState;
  final String? message;

  const AdminDetailsState({
    this.deleteState = RequestState.initial,
    this.productsState = RequestState.initial,
    this.products = const [],
    this.selectedProduct,
    this.message = "",
  });
  AdminDetailsState copyWith({
    ProductEntity? selectedProduct,
    List<ProductEntity>? products,
    RequestState? deleteState,
    RequestState? productsState,
    String? message,
  }) =>
      AdminDetailsState(
        selectedProduct: selectedProduct ?? this.selectedProduct,
        deleteState: deleteState ?? this.deleteState,
        productsState: productsState ?? this.productsState,
        products: products ?? this.products,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        selectedProduct,
        deleteState,
        productsState,
        products,
        message,
      ];
}

import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';
import '../../../domain/entities/product_entity.dart';

class ExploreProductsState extends Equatable {
  //final RequestState deleteProductState;
  final RequestState shirtsState;
  final RequestState jacketsState;
  final List<ProductEntity> jackets;
  final List<ProductEntity> shirts;
  final String? errorMessage;

  const ExploreProductsState({
    this.shirtsState = RequestState.initial,
    this.jacketsState = RequestState.initial,
    //this.deleteProductState = RequestState.initial,
    this.jackets = const [],
    this.shirts = const [],
    this.errorMessage,
  });

  ExploreProductsState copyWith({
    //RequestState? deleteProductState,
    RequestState? shirtsState,
    RequestState? jacketsState,
    List<ProductEntity>? jackets,
    List<ProductEntity>? shirts,
    String? errorMessage,
  }) =>
      ExploreProductsState(
        //deleteProductState: deleteProductState ?? this.deleteProductState,
        shirtsState: shirtsState ?? this.shirtsState,
        jacketsState: jacketsState ?? this.jacketsState,
        errorMessage: errorMessage ?? this.errorMessage,
        jackets: jackets ?? this.jackets,
        shirts: shirts ?? this.shirts,
      );

  @override
  List<Object?> get props => [
        //deleteProductState,
        jacketsState,
        shirtsState,
        errorMessage,
        jackets,
        shirts,
      ];
}

part of 'update_order_data_cubit.dart';

class UpdateOrderDataState extends Equatable {
  final String message;
  final RequestState updateState;
  final OrderDataEntity? orderData;

  const UpdateOrderDataState({
    this.orderData,
    this.message = "",
    this.updateState = RequestState.initial,
  });

  UpdateOrderDataState copyWith({
    String? message,
    RequestState? updateState,
    OrderDataEntity? orderData,
  }) =>
      UpdateOrderDataState(
        message: message ?? this.message,
        orderData: orderData ?? this.orderData,
        updateState: updateState ?? this.updateState,
      );

  @override
  List<Object?> get props => [
        message,
        orderData,
        updateState,
      ];
}

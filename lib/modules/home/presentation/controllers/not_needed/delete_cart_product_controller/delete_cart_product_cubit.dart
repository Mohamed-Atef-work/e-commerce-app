import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';

part 'delete_cart_product_state.dart';

/*class DeleteCartProductCubit extends Cubit<DeleteCartProductState> {
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  DeleteCartProductCubit(this._deleteFromCartUseCase)
      : super(const DeleteCartProductState());

  Future<void> deleteFromCart(DeleteFromCartParams params) async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await _deleteFromCartUseCase.call(params);
    emit(result.fold(
      (l) =>
          state.copyWith(deleteState: RequestState.error, message: l.message),
      (r) => state.copyWith(deleteState: RequestState.success),
    ));
  }
}*/

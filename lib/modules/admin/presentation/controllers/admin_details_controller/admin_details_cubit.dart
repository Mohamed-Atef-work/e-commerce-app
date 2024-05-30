import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_state.dart';

class AdminDetailsCubit extends Cubit<AdminDetailsState> {
  final AdminRepositoryDomain adminRepo;
  AdminDetailsCubit(this.adminRepo) : super(const AdminDetailsState());

  void product(ProductEntity product) => emit(
        state.copyWith(
          product: product,
          getState: RequestState.success,
          deleteState: RequestState.initial,
        ),
      );

  void deleteProduct() async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await adminRepo.deleteProduct(
        DeleteProductParams(state.product!.id!, state.product!.category));
    emit(
      result.fold(
        (l) =>
            state.copyWith(deleteState: RequestState.error, message: l.message),
        (r) => state.copyWith(deleteState: RequestState.success),
      ),
    );
  }

  void getProduct(GetProductParams params) async {
    emit(state.copyWith(getState: RequestState.loading));

    final result = await adminRepo.getProduct(params);
    emit(
      result.fold(
        (l) => state.copyWith(getState: RequestState.error, message: l.message),
        (product) =>
            state.copyWith(getState: RequestState.success, product: product),
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        message: "",
        getState: RequestState.success,
        deleteState: RequestState.initial,
      ),
    );
  }
}

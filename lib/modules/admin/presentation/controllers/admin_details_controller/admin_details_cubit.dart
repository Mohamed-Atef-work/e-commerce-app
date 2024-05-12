import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_state.dart';

class AdminDetailsCubit extends Cubit<AdminDetailsState> {
  final AdminRepositoryDomain adminRepo;
  AdminDetailsCubit(this.adminRepo) : super(const AdminDetailsState());

  void product(ProductEntity product) {
    emit(state.copyWith(product: product));
  }

  Future<void> deleteProduct() async {
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

  void reset() {
    emit(state.copyWith(message: "", deleteState: RequestState.initial));
  }
}

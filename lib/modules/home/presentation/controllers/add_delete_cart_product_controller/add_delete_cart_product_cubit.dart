import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_cart_product_state.dart';

class AddDeleteCartProductCubit extends Cubit<AddDeleteCartProductState> {
  AddDeleteCartProductCubit() : super(AddDeleteCartProductInitial());
}

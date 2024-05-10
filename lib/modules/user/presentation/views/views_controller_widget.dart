import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/user/presentation/views/cart_view.dart';
import 'package:e_commerce_app/modules/shared/presentation/views/account_view.dart';
import 'package:e_commerce_app/modules/user/presentation/views/products_view.dart';
import 'package:e_commerce_app/modules/user/presentation/views/favorites_view.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_state.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/user_layout_controller/user_layout_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/user_layout_controller/user_layout_states.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

class UserViewsControllerWidget extends StatelessWidget {
  const UserViewsControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        SharedUserDataState userDataState =
            BlocProvider.of<SharedUserDataCubit>(context).state;
        final uId = userDataState.sharedEntity!.user.userEntity.id;

        if (state.currentIndex == 0) {
          return const UserProductsView();
        } else if (state.currentIndex == 1) {
          BlocProvider.of<ManageCartProductsCubit>(context)
              .getCartProducts(uId);
          return const CartView();
        } else if (state.currentIndex == 2) {
          BlocProvider.of<GetFavoriteCubit>(context).getFavorites(uId);
          return const FavoritesView<ProductDetailsCubit>();
        } else {
          return const AccountView();
        }
      },
    );
  }
}

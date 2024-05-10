import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_states.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/admin_orders_view.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/admin_products_view.dart';
import 'package:e_commerce_app/modules/shared/presentation/views/profile_view.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/views/account_view.dart';
import 'package:e_commerce_app/modules/user/presentation/views/favorites_view.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminViewsControllerWidget extends StatelessWidget {
  const AdminViewsControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLayoutCubit, AdminLayoutState>(
        builder: (context, state) {
      final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
      final uId = userData.sharedEntity!.user.userEntity.id;
      if (state.currentIndex == 0) {
        return const AdminProductsView();
      } else if (state.currentIndex == 1) {
        return const AdminOrderView();
      } else if (state.currentIndex == 2) {
        BlocProvider.of<GetFavoriteCubit>(context).getFavorites(uId);
        return const FavoritesView<AdminDetailsCubit>();
      } else {
        return const ProfileView();
      }
    });
  }
}

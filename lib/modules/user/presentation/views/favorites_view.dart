import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_state.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/loading_favorite_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/favorite_widget.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class FavoritesView<CubitName> extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoriteCubit, GetFavoriteState>(
      builder: (context, state) {
        if (state.getFavState == RequestState.success) {
          if (state.favorites.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.favorites.length,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) =>
                  FavoriteWidget<CubitName>(state.favorites[index]),
              separatorBuilder: (_, __) => const DividerComponent(),
            );
          } else {
            return const MessengerComponent(AppStrings.favoriteIsEmpty);
          }
        } else {
          return const LoadingFavoriteWidget();
        }
      },
    );
  }
}

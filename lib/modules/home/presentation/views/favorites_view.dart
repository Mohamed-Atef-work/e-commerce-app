import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorites_controller/get_favorites_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.favState == RequestState.loading) {
          return const LoadingWidget();
        } else {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.favorites.length,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                FavoriteWidget(favoriteEntity: state.favorites[index]),
            separatorBuilder: (context, index) =>
                SizedBox(height: context.height * 0.01),
          );
        }
      },
    );
  }
}

import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_state.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({
    Key? key,
  }) : super(key: key);

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
              itemBuilder: (context, index) =>
                  FavoriteWidget(favoriteEntity: state.favorites[index]),
              separatorBuilder: (context, index) => const DividerComponent(),
            );
          } else {}
          return const Center(
            child: CustomText(
              fontSize: 25,
              textColor: AppColors.black,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.pacifico,
              text: AppStrings.favoriteIsEmpty,
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}

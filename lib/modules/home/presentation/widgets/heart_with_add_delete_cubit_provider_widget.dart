import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/loading_heart_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_delete_favorite_controller/add_delete_favorite_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_delete_favorite_controller/add_delete_favorite_state.dart';

class HeartWithAddDeleteCubitProviderWidget extends StatelessWidget {
  final ProductEntity product;
  final Color heartColor;
  const HeartWithAddDeleteCubitProviderWidget(
      {super.key, required this.product,required this.heartColor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AddDeleteFavoriteCubit>()..setHeartColor(heartColor),
      child: BlocBuilder<AddDeleteFavoriteCubit, AddDeleteFavoriteState>(
        builder: (context, state) {
          if (state.requestState == RequestState.loading) {
            return const LoadingHeartWidget();
          } else {
            return IconButton(
              splashRadius: 20,
              highlightColor: Colors.transparent,
              //splashColor: Colors.red,
              onPressed: () {
                /// to complete the cubit and the module
                BlocProvider.of<AddDeleteFavoriteCubit>(context).addOrDelete(
                  AddDeleteFavoriteParams(
                    category: product.category,
                    productId: product.id,
                    uId: "uId",
                  ),
                );
              },
              icon: Icon(Icons.favorite, color: state.heartColor),
            );
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_favorite_controller/add_favorite_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_favorite_controller/add_favorite_state.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/loading_heart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/fire_store_services/favorite.dart';
import '../../data/data_source/favorite_remote_data_source.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsImageWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AddFavoriteCubit>(),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: context.width / 1.3,
              height: context.height / 2.3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.network(
                product.image,
                fit: BoxFit.fill,
                height: context.height / 4,
              ),
            ),
            BlocBuilder<AddFavoriteCubit, AddFavoriteState>(
              builder: (context, state) {
                switch (state.addState) {
                  case RequestState.loading:
                    return const LoadingHeartWidget();
                  case RequestState.success:
                    return IconButton(
                      splashRadius: 20,
                      splashColor: Colors.red,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    );
                  default:
                    return IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.red,
                      splashRadius: 20,
                      onPressed: () {
                        /// to complete the cubit and the module
                        BlocProvider.of<AddFavoriteCubit>(context).addFavorite(
                          AddFavoriteParams(
                            category: product.category,
                            productId: product.id,
                            uId: "uId",
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

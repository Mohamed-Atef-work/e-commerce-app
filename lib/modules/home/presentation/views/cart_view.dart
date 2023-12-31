import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_cart_products_controller/get_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorites_controller/get_favorites_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/cart_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartProductsCubit, GetCartProductsState>(
      builder: (context, state) {
        if (state.getCartState == RequestState.success) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.products.length,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                CartWidget(cartEntity: state.products[index]),
            separatorBuilder: (context, index) =>
                SizedBox(height: context.height * 0.01),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}

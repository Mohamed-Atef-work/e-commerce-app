import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/config/routes/pages.dart';import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'favorite_product_widget.dart';

class FavoriteWidget<CubitName> extends StatelessWidget {
  final FavoriteEntity favoriteEntity;
  const FavoriteWidget(this.favoriteEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            CustomText(
              fontSize: 25,
              fontFamily: kPacifico,
              fontWeight: FontWeight.bold,
              text: favoriteEntity.category,
            ),
            SizedBox(height: context.height * 0.01),
          ] +
          List.generate(
            favoriteEntity.products.length,
            (index) => FavoriteProductWidget(
              onPressed: () {
                if (CubitName == AdminDetailsCubit) {
                  BlocProvider.of<AdminDetailsCubit>(context)
                      .product(favoriteEntity.products[index]);
                  Navigator.pushNamed(context, Screens.adminDetailsScreen);
                } else {
                  BlocProvider.of<ProductDetailsCubit>(context)
                      .product(favoriteEntity.products[index]);
                  Navigator.pushNamed(context, Screens.detailsScreen);
                }
              },
              product: favoriteEntity.products[index],
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';

class FavoriteProductWidget extends StatelessWidget {
  final ProductEntity product;
  final void Function() onPressed;

  const FavoriteProductWidget({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      //hoverColor: Colors.transparent,
      // when putting the mouse on it .
      splashColor: Colors.amber.withOpacity(0.5),
      // the color is spread gradually, when pressing on.
      highlightColor: Colors.transparent,
      // changes all it's color ,after pressing on it .
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 170,
              height: 165,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: product.id!,
                child: Image.network(
                  fit: BoxFit.cover,
                  product.image,
                ),
              ),
            ),
            SizedBox(width: context.width * 0.02),
            SizedBox(
              height: 165,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    maxLines: 3,
                    fontSize: 18,
                    text: product.name,
                    textColor: Colors.black,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    maxLines: 3,
                    fontSize: 18,
                    textColor: Colors.black,
                    textAlign: TextAlign.left,
                    text: product.description,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            HeartWihMangeFavoriteCubitProviderWidget(
              heartColor: Colors.red,
              product: product,
            ),
          ],
        ),
      ),
    );
  }
}

/*class FavoriteProductWidget extends StatelessWidget {
  final ProductEntity product;
  final void Function() onTap;
  const FavoriteProductWidget({
    super.key,
    required this.product,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.width * 0.4,
            height: context.height * 0.3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(product.image, fit: BoxFit.cover),
          ),
          SizedBox(height: context.height * 0.01),
          CustomText(
            text: product.name,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textColor: Colors.white,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: context.height * 0.01),
          CustomText(
            maxLines: 3,
            fontSize: 14,
            textColor: Colors.white,
            textAlign: TextAlign.left,
            text: product.description,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}*/

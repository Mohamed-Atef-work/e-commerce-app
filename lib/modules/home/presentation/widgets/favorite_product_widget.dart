import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:flutter/material.dart';

class FavoriteProductWidget extends StatelessWidget {
  final int index;


  final ProductEntity product;
  final void Function() onPressed;

  const FavoriteProductWidget({
    super.key,
    required this.index,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.width * 0.01),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Container(
          width: 180,
          height: 167,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Image.network(product.image, fit: BoxFit.cover),
        ),
        label: Stack(
          alignment: Alignment.topRight,
          children: [
            HeartWihMangeFavoriteCubitProviderWidget(
              heartColor: Colors.red,
              product: product,
              index: index,
            ),
            SizedBox(
              height: 165,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: product.name,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.left,
                    fontSize: 20,
                    textColor: Colors.black,
                  ),
                  CustomText(
                    text: product.description,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    textColor: Colors.black,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  CustomText(
                    text: product.location,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    textColor: Colors.black,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
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

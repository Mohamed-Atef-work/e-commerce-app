import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
    final width = context.width;
    final height = context.height;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      //hoverColor: Colors.transparent,
      // when putting the mouse on it .
      splashColor: Colors.amber.withOpacity(0.5),
      // the color is spread gradually, when pressing on.
      highlightColor: Colors.amber.withOpacity(0.5),
      // changes all it's color ,after pressing on it .
      child: Padding(
        padding: EdgeInsets.all(width * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.4,
              height: height * 0.23,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: product.id!,
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: Svg(Images.loading),
                  image: NetworkImage(product.image),
                ),
              ),
            ),
            SizedBox(width: width * 0.01),
            Expanded(
              child: SizedBox(
                height: height * 0.23,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: CustomText(
                            maxLines: 1,
                            fontSize: 23,
                            text: product.name,
                            fontFamily: kPacifico,
                            textColor: Colors.black,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        HeartWihMangeFavoriteCubitProviderWidget(
                          heartColor: Colors.red,
                          product: product,
                          iconsSize: 35,
                        ),
                      ],
                    ),
                    CustomText(
                      maxLines: 4,
                      fontSize: 18,
                      textColor: kDarkBrown,
                      textAlign: TextAlign.left,
                      text: product.description,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

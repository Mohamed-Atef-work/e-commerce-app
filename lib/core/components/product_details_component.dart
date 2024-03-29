import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';

class ProductWithMoreDetailsComponent extends StatelessWidget {
  final ProductEntity product;
  final double imageWidth;
  final double imageHeight;
  const ProductWithMoreDetailsComponent({
    super.key,
    required this.product,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductDetailsCubit>(context).product(product);
        Navigator.pushNamed(context, Screens.detailsScreen);
        print(product.id);
        print(product.category);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange.shade300,
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(
                    product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: product.name,
              fontSize: 16,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              text: "\$${product.price}",
              fontSize: 16,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductComponent extends StatelessWidget {
  final void Function() onPressed;
  final ProductEntity product;
  const ProductComponent({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.orange.shade300,
          color: kWhiteGray,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              fontSize: 20,
              text: product.category,
              fontFamily: kPacifico,
            ),
            SizedBox(height: height * 0.01),
            CustomText(
              fontSize: 16,
              text: product.name,
              textColor: Colors.black,
            ),
            SizedBox(height: height * 0.02),
            CustomText(
              fontSize: 16,
              textColor: Colors.black,
              text: "\$${product.price}",
            ),
          ],
        ),
      ),
    );
  }
}

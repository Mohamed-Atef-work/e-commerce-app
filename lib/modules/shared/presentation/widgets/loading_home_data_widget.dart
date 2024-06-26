import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class LoadingHomeProductsWidget extends StatelessWidget {
  const LoadingHomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    return CustomFadingWidget(
      child: GridView.builder(
        itemCount: 6,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: height * 0.005,
          crossAxisSpacing: width * 0.01,
          childAspectRatio: 1 / 1.6,
          crossAxisCount: 2,
        ),
        itemBuilder: (_, __) => AnimationHelperWidget(
          width: double.infinity,
          height: height * 0.03,
          color: kWhiteGray,
        ),
      ),
    );
  }
}

class LoadingCategoriesWidget extends StatelessWidget {
  const LoadingCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return CustomFadingWidget(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          top: 5,
          bottom: 5,
        ),
        child: SizedBox(
          height: height * 0.065,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, __) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: height * 0.3,
              width: width * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(width: width * 0.01),
          ),
        ),
      ),
    );
  }
}

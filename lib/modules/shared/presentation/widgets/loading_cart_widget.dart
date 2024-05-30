import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingCartWidget extends StatelessWidget {
  const LoadingCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        separatorBuilder: (_, __) => const DividerComponent(),
        itemBuilder: (_, __) => const CartProductLoadingWidget(),
      ),
    );
  }
}

class CartProductLoadingWidget extends StatelessWidget {
  const CartProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimationHelperWidget(
          width: width * 0.32,
          height: height * 0.17,
        ),
        SizedBox(
          width: width * 0.6,
          height: height * 0.17,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimationHelperWidget(
                width: width * 0.08,
                height: height * 0.03,
                child: CustomText(
                  text: "\$",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textColor: kDarkBrown.withOpacity(0.2),
                ),
              ),
              AnimationHelperWidget(
                width: width * 0.25,
                height: height * 0.025,
              ),
              Container(
                height: height * 0.04,
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: kWhiteGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      size: 25,
                      color: Colors.white,
                      Icons.add_circle_outline,
                    ),
                    Spacer(),
                    Icon(
                      size: 25,
                      color: Colors.white,
                      Icons.remove_circle_outline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

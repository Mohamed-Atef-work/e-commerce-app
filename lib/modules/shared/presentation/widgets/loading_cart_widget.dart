import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: AnimationHelperWidget(
              width: context.width * 0.3,
              height: context.height * 0.2,
            ),
          ),
          SizedBox(width: context.width * 0.04),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimationHelperWidget(
                width: context.width * 0.25,
                height: context.height * 0.025,
              ),
              SizedBox(height: context.height * 0.03),
              Container(
                width: context.width * 0.3,
                height: context.height * 0.04,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.symmetric(horizontal: 2),
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
                      Icons.add_circle_outline,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          AnimationHelperWidget(
            width: context.width * 0.08,
            height: context.height * 0.03,
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
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
        itemBuilder: (context, index) => const CartProductLoadingWidget(),
        separatorBuilder: (context, index) => const DividerComponent(),
      ),
    );
  }
}

class CartProductLoadingWidget extends StatelessWidget {
  const CartProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: AnimationHelperWidget(
              height: context.height * 0.2,
              width: context.width * 0.3,
            ),
          ),
          SizedBox(width: context.width * 0.04),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimationHelperWidget(
                height: context.height * 0.03,
                width: context.width * 0.2,
              ),
              SizedBox(height: context.height * 0.03),
              AnimationHelperWidget(
                height: context.height * 0.04,
                width: context.width * 0.3,
              ),
            ],
          ),
          const Spacer(),
          AnimationHelperWidget(
            height: context.height * 0.03,
            width: context.width * 0.08,
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingFavoriteWidget extends StatelessWidget {
  const LoadingFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: ListView.separated(
        itemCount: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) => const LoadingFavoriteProductWidget(),
        separatorBuilder: (context, index) => const DividerComponent(),
      ),
    );
  }
}

class LoadingFavoriteProductWidget extends StatelessWidget {
  const LoadingFavoriteProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            AnimationHelperWidget(
              width: width * 0.2,
              height: height * 0.03,
            ),
            SizedBox(height: height * 0.01),
          ] +
          List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimationHelperWidget(
                    width: width * 0.4,
                    height: height * 0.23,
                  ),
                  SizedBox(width: width * 0.01),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.23,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimationHelperWidget(
                                  width: width * 0.25, height: height * 0.03),
                              const Icon(
                                size: 30,
                                color: Colors.white,
                                Icons.favorite_border,
                              ),
                            ],
                          ),
                          AnimationHelperWidget(
                              width: width * 0.3, height: height * 0.02),
                          AnimationHelperWidget(
                              width: width * 0.4, height: height * 0.02),
                          AnimationHelperWidget(
                              width: width * 0.5, height: height * 0.02),
                          AnimationHelperWidget(
                              width: width * 0.6, height: height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

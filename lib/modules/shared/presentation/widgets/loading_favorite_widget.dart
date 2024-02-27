import 'package:e_commerce_app/core/animation/animation_helper_widget.dart';
import 'package:e_commerce_app/core/animation/custom_fading_widget.dart';
import 'package:e_commerce_app/core/components/divider_component.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
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
  const LoadingFavoriteProductWidget({Key? key}) : super(key: key);

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
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: AnimationHelperWidget(
                      width: width * 0.3,
                      height: height * 0.2,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  SizedBox(
                    height: height * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AnimationHelperWidget(
                          width: width * 0.2,
                          height: height * 0.025,
                        ),
                        AnimationHelperWidget(
                          width: width * 0.2,
                          height: height * 0.025,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    size: 30,
                    color: Colors.white,
                    Icons.favorite_border,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

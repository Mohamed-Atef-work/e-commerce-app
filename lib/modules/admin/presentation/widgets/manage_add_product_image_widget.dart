import 'dart:io';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ManageAddProductImageWidget extends StatelessWidget {
  const ManageAddProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<AddProductCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.07),
      child: BlocBuilder<AddProductCubit, AddProductState>(
        buildWhen: _listenWhen,
        builder: (_, state) {
          switch (state.thereIsImage) {
            case false:
              return const EmptyImageWidget();
            case true:
              return Container(
                clipBehavior: Clip.antiAlias,
                height: context.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: Svg(Images.loading),
                  image: FileImage(File(controller.state.imagePath!)),
                ),
              );
          }
        },
      ),
    );
  }

  bool _listenWhen(AddProductState previous, AddProductState current) =>
      previous.thereIsImage != current.thereIsImage;
}

class EmptyImageWidget extends StatelessWidget {
  const EmptyImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: kWhiteGray),
      child: const Center(
        child: CustomText(
          fontSize: 20,
          text: AppStrings.image,
          fontFamily: kPacifico,
        ),
      ),
    );
  }
}

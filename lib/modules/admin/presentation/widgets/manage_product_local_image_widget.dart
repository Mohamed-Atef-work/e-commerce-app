import 'dart:io';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';

class ManageProductImageWidget extends StatelessWidget {
  const ManageProductImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditAddProductCubit>(context);
    return BlocBuilder<EditAddProductCubit, EditAddProductState>(
      buildWhen: (previous, current) =>
          previous.imageState != current.imageState,
      builder: (context, state) {
        switch (state.imageState) {
          case ImageState.noImage:
            return Container(
              width: double.infinity,
              height: context.height * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kWhiteGray),
              child: const Center(
                child: CustomText(
                  fontSize: 20,
                  text: AppStrings.image,
                  fontFamily: kPacifico,
                ),
              ),
            );
          case ImageState.network:
            return Image.network(
              controller.state.productToBeUpdated!.image,
              height: context.height * 0.3,
              fit: BoxFit.contain,
            );
          case ImageState.local:
            return Image.file(
              File(controller.state.imagePath!),
              height: context.height * 0.3,
              fit: BoxFit.contain,
            );
        }
      },
    );
  }
}

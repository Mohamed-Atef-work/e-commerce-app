import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/images.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_state.dart';

class ManageProductImageWidget extends StatelessWidget {
  const ManageProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditProductCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.07),
      child: BlocBuilder<EditProductCubit, EditProductState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          switch (state.imageState) {
            case ImageState.network:
              return Container(
                clipBehavior: Clip.antiAlias,
                height: context.height * 0.4,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FadeInImage(
                  fit: BoxFit.contain,
                  image:
                      NetworkImage(controller.state.productToBeUpdated!.image),
                  placeholder: Svg(Images.loading),
                ),
              );
            case ImageState.local:
              return Container(
                clipBehavior: Clip.antiAlias,
                height: context.height * 0.4,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FadeInImage(
                  fit: BoxFit.contain,
                  placeholder: Svg(Images.loading),
                  image: FileImage(File(controller.state.imagePath!)),
                ),
              );
            case ImageState.noImage:
              return Container(
                clipBehavior: Clip.antiAlias,
                height: context.height * 0.4,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image(image: Svg(Images.loading)),
              );
          }
        },
      ),
    );
  }

  bool _buildWhen(EditProductState previous, EditProductState current) =>
      previous.imageState != current.imageState;
}

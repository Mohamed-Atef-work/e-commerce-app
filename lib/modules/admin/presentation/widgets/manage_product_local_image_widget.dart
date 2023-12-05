import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';

class ManageProductImageWidget extends StatelessWidget {
  const ManageProductImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = BlocProvider.of<EditAddProductCubit>(context);
    return BlocBuilder<EditAddProductCubit, EditAddProductState>(
      buildWhen: (previous, current) =>
          previous.imageState != current.imageState,
      builder: (context, state) {
        switch (state.imageState) {
          case ImageState.noImage:
            return SizedBox(
              height: height * 0.1,
            );
          case ImageState.network:
            return Image.network(
              controller.state.productToBeUpdated!.image,
              height: height * 0.3,
              fit: BoxFit.contain,
            );
          case ImageState.local:
            return Image.file(
              File(controller.state.imagePath!),
              height: height * 0.3,
              fit: BoxFit.contain,
            );
        }
      },
    );
  }
}

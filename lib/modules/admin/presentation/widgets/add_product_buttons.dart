import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';

import '../../../../core/utils/enums.dart';

class AddProductButtons extends StatelessWidget {
  const AddProductButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final EditAddProductCubit controller =
        BlocProvider.of<EditAddProductCubit>(context);
    return BlocBuilder<EditAddProductCubit, EditAddProductState>(
      buildWhen: (previous, current) =>
          previous.productState != current.productState ||
          previous.imageButtonText != current.imageButtonText,
      builder: (context, state) {
        return state.productState == RequestState.loading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                child: const LoadingWidget(),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: width * 0.2,
                  right: width * 0.2,
                  top: height * 0.03,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      text: state.addUpdateButtonText,
                      onPressed: () {
                        controller.execute();
                      },
                      width: width * 0.5,
                      height: height * 0.06,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.getImageFromGallery();
                      },
                      child: CustomText(
                        fontSize: 15,
                        text: state.imageButtonText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

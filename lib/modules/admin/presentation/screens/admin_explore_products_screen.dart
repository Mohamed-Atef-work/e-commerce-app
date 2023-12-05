import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/explore_product_controller/explore_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/explore_product_controller/explore_product_state.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/explore_screen_product_widget.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_strings.dart';

class ExploreProductsScreen extends StatelessWidget {
  const ExploreProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider<ExploreProductsCubit>(
      create: (context) => sl<ExploreProductsCubit>()
        ..shirtsStream()
        ..jacketsStream(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColorYellow,
          centerTitle: true,
          title: const CustomText(
            text: AppStrings.products,
            fontSize: 30,
            fontFamily: AppStrings.pacifico,
            fontWeight: FontWeight.bold,
            textColor: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.primaryColorYellow,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.03,
                ),
                automaticIndicatorColorAdjustment: false,
                labelPadding: const EdgeInsets.all(8),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                enableFeedback: true,
                indicatorWeight: 4,
                tabs: const [
                  CustomText(
                    text: FirebaseStrings.shirts,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: FirebaseStrings.jackets,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocBuilder<ExploreProductsCubit, ExploreProductsState>(
                      builder: (context, state) {
                        if (state.shirtsState == RequestState.success) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: GridView.builder(
                              itemCount: state.shirts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.5,
                                crossAxisSpacing: width * 0.01,
                                mainAxisSpacing: height * 0.005,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  AdminProductWidget(
                                product: state.shirts[index],
                              ),
                            ),
                          );
                        } else {
                          return const LoadingWidget();
                        }
                      },
                    ),
                    BlocBuilder<ExploreProductsCubit, ExploreProductsState>(
                      builder: (context, state) {
                        if (state.jacketsState == RequestState.success) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: GridView.builder(
                              itemCount: state.jackets.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.5,
                                crossAxisSpacing: width * 0.01,
                                mainAxisSpacing: height * 0.005,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  AdminProductWidget(
                                      product: state.jackets[index]),
                            ),
                          );
                        } else {
                          return const LoadingWidget();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

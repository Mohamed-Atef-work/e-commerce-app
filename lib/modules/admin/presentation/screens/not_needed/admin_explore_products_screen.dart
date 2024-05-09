import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/explore_screen_product_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/explore_product_controller/explore_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/explore_product_controller/explore_product_state.dart';

class ExploreProductsScreen extends StatelessWidget {
  const ExploreProductsScreen({super.key});

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
          backgroundColor: kPrimaryColorYellow,
          centerTitle: true,
          title: const CustomText(
            fontSize: 30,
            fontFamily: kPacifico,
            textColor: Colors.black,
            text: AppStrings.products,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColorYellow,
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
                    fontSize: 17,
                    text: kShirts,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    fontSize: 17,
                    text: kJackets,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_button_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/layout_views_controller_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/admin_bottom_navigation_bar_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_states.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/products_view_controller/products_view_cubit.dart';

class AdminLayoutScreen extends StatelessWidget {
  const AdminLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminLayoutCubit>(
          create: (context) => sl<AdminLayoutCubit>(),
        ),
        BlocProvider<ProductsViewCubit>(
          create: (context) => sl<ProductsViewCubit>()
            ..loadCategories()
            ..loadProductsOfTheFirstCategory(),
        ),
        /*BlocProvider<AdminDetailsCubit>(
          create: (context) => sl<AdminDetailsCubit>(),
        ),*/
      ],
      child: BlocBuilder<AdminLayoutCubit, AdminLayoutState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: const AdminViewsControllerWidget(),
            floatingActionButton: const AddProductButtonWidget(),
            bottomNavigationBar: const AdminBottomNavigationBarWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) => appBar(
        title: BlocProvider.of<AdminLayoutCubit>(context).state.appBarTitle,
      );
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
final List<String> _tabs = [
  AppStrings.jackets,
  AppStrings.shirts,
  AppStrings.suits,
];

final List<ProductEntity> _products = List.generate(
  10,
  (index) => const ProductEntity(
    id: "",
    price: 100,
    location: "home",
    category: "jackets",
    description: "we are testing",
    name: "Product details Screen task",
    image:
        "https://firebasestorage.googleapis.com/v0/b/ecommerce-39620.appspot.com/o/productImagesIMG-20231030-WA0011.jpg?alt=media&token=ddccf23c-2e3b-420b-a0a4-5cc527aff36b",
  ),
);

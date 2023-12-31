import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_cart_products_controller/get_cart_products_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorites_controller/get_favorites_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/layout_controller/layout_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/layout_controller/layout_states.dart';
import 'package:e_commerce_app/modules/home/presentation/views/favorites_view.dart';
import 'package:e_commerce_app/modules/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>()
            ..loadCategories()
            ..loadProductsOfTheFirstCategory(),
        ),
        BlocProvider<GetFavoritesCubit>(
          create: (context) => sl<GetFavoritesCubit>()..getFavorites(),
        ),
        BlocProvider<GetCartProductsCubit>(
          create: (context) => sl<GetCartProductsCubit>()..getCartProducts(),
        ),
        BlocProvider<LayoutCubit>(
          create: (context) => sl<LayoutCubit>(),
        ),
      ],
      child: BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.amber,
          appBar: _appBar(context),
          body: _body(context),
          bottomNavigationBar: _bottomNavBar(context),
        );
      }),
    );
  }

  Widget _body(BuildContext context) {
    LayoutState state = BlocProvider.of<LayoutCubit>(context).state;
    if (state.currentIndex == 0) {
      return const HomeView();
    } else if (state.currentIndex == 1) {
      return const HomeView();
    } else {
      return const FavoritesView();
    }
  }

  PreferredSizeWidget _appBar(BuildContext context) => AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.primaryColorYellow,
        title: CustomText(
          fontSize: 30,
          textColor: AppColors.black,
          fontWeight: FontWeight.bold,
          fontFamily: AppStrings.pacifico,
          text: BlocProvider.of<LayoutCubit>(context).state.appBarTitle,
        ),
      );

  BottomNavigationBar _bottomNavBar(BuildContext context) =>
      BottomNavigationBar(
        unselectedItemColor: Colors.orange,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryColorYellow,
        onTap: (index) {
          BlocProvider.of<LayoutCubit>(context).newScreen(index);
        },
        currentIndex: BlocProvider.of<LayoutCubit>(context).state.currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.shopping_cart, color: Colors.white),
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.favorite, color: Colors.white),
            icon: Icon(Icons.favorite, color: Colors.black),
          ),
        ],
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
    description: "we are testing",
    location: "home",
    category: "jackets",
    price: "100",
    image:
        "https://firebasestorage.googleapis.com/v0/b/ecommerce-39620.appspot.com/o/productImagesIMG-20231030-WA0011.jpg?alt=media&token=ddccf23c-2e3b-420b-a0a4-5cc527aff36b",
    name: "Product details Screen task",
    id: "",
  ),
);

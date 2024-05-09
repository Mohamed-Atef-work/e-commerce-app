import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/views/favorites_view.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/admin_orders_view.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/admin_profile_view.dart';
import 'package:e_commerce_app/modules/admin/presentation/views/admin_products_view.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_states.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';

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
          body: _body(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const AddProductButtonWidget(),
          bottomNavigationBar: _bottomNavBar(context),
        );
      }),
    );
  }

  Widget _body(BuildContext context) {
    AdminLayoutState state = BlocProvider.of<AdminLayoutCubit>(context).state;
    final userData = BlocProvider.of<SharedUserDataCubit>(context).state;
    final uId = userData.sharedEntity!.user.userEntity.id;
    if (state.currentIndex == 0) {
      return const AdminProductsView();
    } else if (state.currentIndex == 1) {
      return const AdminOrderView();
    } else if (state.currentIndex == 2) {
      BlocProvider.of<GetFavoriteCubit>(context).getFavorites(uId);
      return const FavoritesView<AdminDetailsCubit>();
    } else {
      return const AdminProfileView();
    }
  }

  PreferredSizeWidget _appBar(BuildContext context) => appBar(
        title: BlocProvider.of<AdminLayoutCubit>(context).state.appBarTitle,
      );

  BottomNavigationBar _bottomNavBar(BuildContext context) =>
      BottomNavigationBar(
        //unselectedItemColor: Colors.orange,
        type: BottomNavigationBarType.fixed,
        fixedColor: kPrimaryColorYellow,
        backgroundColor: kPrimaryColorYellow,
        onTap: (index) {
          BlocProvider.of<AdminLayoutCubit>(context).newView(index);
        },
        currentIndex:
            BlocProvider.of<AdminLayoutCubit>(context).state.currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(Icons.shopping_basket, color: Colors.white),
            ),
            icon: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(Icons.shopping_basket, color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
            icon: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(Icons.favorite, color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.person_rounded, color: Colors.white),
            icon: Icon(Icons.person_rounded, color: Colors.black),
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

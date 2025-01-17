import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/services/fcm/fcm_service.dart';
import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/presentation/views/views_controller_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/user_bottom_navigation_bar_widget.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/user_layout_controller/user_layout_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/user_layout_controller/user_layout_states.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/products_view_controller/products_view_cubit.dart';

class UserLayoutScreen extends StatelessWidget {
  const UserLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fcm = FCMService(DioServices());
    final message = fcm.interactTerminated();

    message.then((value) {
      if (value != null) {
        showMyToast(
          value.data.toString(),
          context,
          Colors.green,
        );
        print("data is -------> ${value.data}");
      }
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsViewCubit>(
          create: (_) => sl<ProductsViewCubit>()
            ..loadCategories()
            ..loadProductsOfTheFirstCategory(),
        ),
        BlocProvider<UserLayoutCubit>(create: (_) => sl<UserLayoutCubit>()),
      ],
      child: BlocBuilder<UserLayoutCubit, UserLayoutState>(
          builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          body: const UserViewsControllerWidget(),
          bottomNavigationBar: const UserBottomNavigationBarWidget(),
        );
      }),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) => appBar(
        title: BlocProvider.of<UserLayoutCubit>(context).state.appBarTitle,
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

final List<ProductEntity> _products = List.generate(
  10,
  (index) => const ProductEntity(
    description: "we are testing",
    category: "jackets",
    price: 100,
    image:
        "https://firebasestorage.googleapis.com/v0/b/ecommerce-39620.appspot.com/o/productImagesIMG-20231030-WA0011.jpg?alt=media&token=ddccf23c-2e3b-420b-a0a4-5cc527aff36b",
    name: "Product details Screen task",
    id: "",
  ),
);

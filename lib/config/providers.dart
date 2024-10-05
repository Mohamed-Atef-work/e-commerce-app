import 'service_locator/sl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';

providers() => [
      /// shared < --------------------------------------------------------- >
      BlocProvider<SharedUserDataCubit>(
          create: (_) => sl<SharedUserDataCubit>()),
      BlocProvider<GetFavoriteCubit>(create: (_) => sl<GetFavoriteCubit>()),

      /// User < ----------------------------------------------------------- >
      BlocProvider<ManageCartProductsCubit>(
          create: (_) => sl<ManageCartProductsCubit>()),
      BlocProvider<ProductDetailsCubit>(
          create: (_) => sl<ProductDetailsCubit>()),

      /// Admin < ----------------------------------------------------------- >
      BlocProvider<AdminDetailsCubit>(create: (_) => sl<AdminDetailsCubit>()),
    ];

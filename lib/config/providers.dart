import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/product_details_controller/product_details_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_cart_products_controller/manage_cart_products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

providers() => [
      /// shared < --------------------------------------------------------- >
      BlocProvider<SharedUserDataCubit>(
        create: (context) => sl<SharedUserDataCubit>(),
      ),
      BlocProvider<GetFavoriteCubit>(
        create: (context) => sl<GetFavoriteCubit>(),
      ),

      /// User < ----------------------------------------------------------- >
      BlocProvider<ManageCartProductsCubit>(
        create: (context) => sl<ManageCartProductsCubit>(),
      ),
      BlocProvider<ProductDetailsCubit>(
        create: (context) => sl<ProductDetailsCubit>(),
      ),

      /// Admin < ----------------------------------------------------------- >
      BlocProvider<AdminDetailsCubit>(
        create: (context) => sl<AdminDetailsCubit>(),
      ),
      /*BlocProvider<SegaCubit>(
          create: (context) => SegaCubit(),
        ),*/
    ];

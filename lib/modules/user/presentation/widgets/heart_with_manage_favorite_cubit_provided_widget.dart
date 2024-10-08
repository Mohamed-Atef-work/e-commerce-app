import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/loading_heart_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/controllers/user_data_controller/user_data_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_cubit.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_state.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HeartWihMangeFavoriteCubitProviderWidget extends StatelessWidget {
  final Color heartColor;
  final double? iconsSize;
  final ProductEntity product;

  const HeartWihMangeFavoriteCubitProviderWidget({
    super.key,
    this.iconsSize,
    required this.product,
    required this.heartColor,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ManageFavoriteCubit>()..setHeartColor(heartColor),
      child: BlocConsumer<ManageFavoriteCubit, ManageFavoriteState>(
        listener: _listener,
        builder: (context, state) {
          if (state.requestState == RequestState.loading) {
            return const LoadingHeartWidget();
          } else {
            return IconButton(
              splashRadius: 20,
              color: Colors.red,
              iconSize: iconsSize ?? 35,
              //highlightColor: Colors.red,
              splashColor: Colors.red,
              onPressed: () => _onPressed(context),
              icon: Icon(Icons.favorite_border, color: state.heartColor),
            );
          }
        },
      ),
    );
  }

  void _listener(BuildContext context, ManageFavoriteState state) {
    if (state.requestState == RequestState.success) {
      showMyToast(
          state.heartColor == Colors.red
              ? AppStrings.added
              : AppStrings.deleted,
          context,
          Colors.green,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 65));
    } else if (state.requestState == RequestState.error) {
      showMyToast(state.message!, context, Colors.red,
          const StyledToastPosition(align: Alignment.bottomCenter, offset: 65));
    }
  }

  _onPressed(BuildContext context) {
    /// to complete the cubit and the module
    final userData = BlocProvider.of<SharedUserDataCubit>(context);
    final uId = userData.state.sharedEntity!.user.userEntity.id;
    BlocProvider.of<GetFavoriteCubit>(context).needToReGet();
    BlocProvider.of<ManageFavoriteCubit>(context).addOrDelete(
      AddDeleteFavoriteParams(
        category: product.category,
        productId: product.id!,
        uId: uId,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/fire_store_services/favorite.dart';
import '../../data/data_source/favorite_remote_data_source.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsImageWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: context.width / 1.3,
            height: context.height / 2.3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Image.network(
              product.image,
              fit: BoxFit.fill,
              height: context.height / 4,
            ),
          ),
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.red,
            splashRadius: 20,
            onPressed: () async {
              /// to complete the cubit and the module
              await FavoriteRemoteDataSource(FavoriteStoreServicesImpl(
                FirebaseFirestore.instance,
              )).addFav(
                uId: "uId",
                category: product.category,
                productId: product.id,
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

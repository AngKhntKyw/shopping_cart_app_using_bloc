import 'package:cart_adding_app/features/pages/home/bloc/home_bloc.dart';
import 'package:cart_adding_app/features/pages/home/models/home_data_product_model.dart';
import 'package:cart_adding_app/features/util/util.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  final bool isAddedIntoCart;
  final bool isAddedIntoWishlist;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
    required this.isAddedIntoCart,
    required this.isAddedIntoWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      delay: const Duration(seconds: 5),
      tween: Tween(begin: 50.0, end: 200.0),
      duration: const Duration(seconds: 10),
      curve: Curves.bounceInOut,
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            homeBloc.add(HomeItemDetailNavigateEvent(
              clickedProduct: productDataModel,
              homeBloc: homeBloc,
              isAddedIntoCart: isAddedIntoCart,
              isAddedIntoWishlist: isAddedIntoWishlist,
            ));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Util.cacheNetworkImage(productDataModel.imageUrl),
                const SizedBox(height: 20),
                Text(
                  productDataModel.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(productDataModel.description.split('.')[0]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${productDataModel.price}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              homeBloc.add(
                                  HomeProductWishlistButtonClickedEvent(
                                      clickedProduct: productDataModel));
                            },
                            icon: Icon(isAddedIntoWishlist
                                ? Icons.favorite
                                : Icons.favorite_border)),
                        IconButton(
                            onPressed: () {
                              homeBloc.add(HomeProductCartButtonClickedEvent(
                                  clickedProduct: productDataModel));
                            },
                            icon: Icon(isAddedIntoCart
                                ? Icons.shopping_bag
                                : Icons.shopping_bag_outlined))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

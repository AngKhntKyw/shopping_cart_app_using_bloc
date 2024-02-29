import 'package:cart_adding_app/features/pages/home/models/home_data_product_model.dart';
import 'package:cart_adding_app/features/pages/wishlist/bloc/wishlist_bloc.dart';
import 'package:cart_adding_app/features/util/util.dart';
import 'package:flutter/material.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  const WishlistTileWidget(
      {super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description.split('.')[0]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    wishlistBloc.add(WishlistRemoveFromWishlistEvent(
                        wishlistItem: productDataModel));
                  },
                  icon: const Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }
}

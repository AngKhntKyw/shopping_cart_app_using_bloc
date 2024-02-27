import 'package:flutter/material.dart';
import 'package:cart_adding_app/features/pages/home/bloc/home_bloc.dart';
import 'package:cart_adding_app/features/pages/home/models/home_data_product_model.dart';
import 'package:cart_adding_app/features/util/util.dart';

class ItemDetail extends StatelessWidget {
  final ProductDataModel item;
  final HomeBloc homeBloc;
  final bool isAddedIntoCart;
  final bool isAddedIntoWishlist;
  const ItemDetail({
    Key? key,
    required this.item,
    required this.homeBloc,
    required this.isAddedIntoCart,
    required this.isAddedIntoWishlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                homeBloc.add(HomeProductWishlistButtonClickedEvent(
                    clickedProduct: item));
              },
              icon: Icon(isAddedIntoWishlist
                  ? Icons.favorite
                  : Icons.favorite_border)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Util.cacheNetworkImage(item.imageUrl),
                    const SizedBox(height: 20),
                    Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(item.description),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 44, 42, 42),
            height: 80,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${item.price}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      !isAddedIntoCart
                          ? homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: item))
                          : null;
                    },
                    child: Text(
                      !isAddedIntoCart ? 'add to cart' : 'already added',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

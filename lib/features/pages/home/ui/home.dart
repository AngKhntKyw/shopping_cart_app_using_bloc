import 'package:cart_adding_app/data/cart_items.dart';
import 'package:cart_adding_app/data/wishlist_items.dart';
import 'package:cart_adding_app/features/pages/cart/ui/cart.dart';
import 'package:cart_adding_app/features/pages/home/bloc/home_bloc.dart';
import 'package:cart_adding_app/features/pages/home/ui/product_tile_widget.dart';
import 'package:cart_adding_app/features/pages/item_detail/ui/item_detail.dart';
import 'package:cart_adding_app/features/pages/wishlist/ui/wishlist.dart';
import 'package:cart_adding_app/features/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Util.changePage(context, const Wishlist());
        } else if (state is HomeNavigateToCartPageActionState) {
          Util.changePage(context, const Cart());
        } else if (state is HomeNavigateToItemDetailPageActionState) {
          Util.changePage(
            context,
            ItemDetail(
              item: state.clickedProduct,
              homeBloc: state.homeBloc,
              isAddedIntoCart: state.isAddedIntoCart,
              isAddedIntoWishlist: state.isAddedIntoWishlist,
            ),
          );
          //
        } else if (state is HomeProductWishlistAddedActionState) {
          Util.showMessage(context, "Added into wishlist");
        } else if (state is HomeProductCartAddedActionState) {
          Util.showMessage(context, "Added into cart");
        } else if (state is HomeProductWishlistAddingFailActionState) {
          Util.showMessage(context, "Already added into wishlist");
        } else if (state is HomeProductCartAddingFailActionState) {
          Util.showMessage(context, "Already added into cart");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          // Loading
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.black, size: 30),
              ),
            );

          // Success
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Grocery App"),
                surfaceTintColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: successState.products.length,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  addSemanticIndexes: false,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    final isAddedIntoCart =
                        cartItems.contains(successState.products[index]);
                    final isAddedIntoWishlist =
                        wishlistItems.contains(successState.products[index]);
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        horizontalOffset: 30,
                        verticalOffset: 300,
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FlipAnimation(
                          duration: const Duration(milliseconds: 3000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          flipAxis: FlipAxis.y,
                          child: ProductTileWidget(
                            productDataModel: successState.products[index],
                            homeBloc: homeBloc,
                            isAddedIntoCart: isAddedIntoCart,
                            isAddedIntoWishlist: isAddedIntoWishlist,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ).animate(delay: const Duration(seconds: 2)).shimmer(),
            );

          // Fail
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );

          // Default

          default:
            return const SizedBox();
        }
      },
    );
  }
}

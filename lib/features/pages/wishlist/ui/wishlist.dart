import 'package:cart_adding_app/features/pages/wishlist/bloc/wishlist_bloc.dart';
import 'package:cart_adding_app/features/pages/wishlist/ui/wishlist_tile_widgete.dart';
import 'package:cart_adding_app/features/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Wishlist'),
      ),
      body: BlocConsumer(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistRemoveFromWishlistActionState) {
            Util.showMessage(context, "Remove item from wishlist");
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            // Loading
            case WishlistLoadingState:
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black, size: 30),
                ),
              );

            // Success
            case WishlistSuccessState:
              final wishListSuccess = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: wishListSuccess.wishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                      productDataModel: wishListSuccess.wishlistItems[index],
                      wishlistBloc: wishlistBloc);
                },
              );

            // Error
            case WishlistErrorState:
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
      ),
    );
  }
}

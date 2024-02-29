import 'package:cart_adding_app/features/pages/cart/bloc/cart_bloc.dart';
import 'package:cart_adding_app/features/pages/cart/ui/cart_tile_widget.dart';
import 'package:cart_adding_app/features/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartRemoveFromCartActionState) {
            Util.showMessage(context, "Removed from cart");
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            // Loading
            case CartLoadingState:
              return Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.black, size: 30),
                ),
              );

            // Success
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  addSemanticIndexes: false,
                  shrinkWrap: false,
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
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
                          child: CartTileWidget(
                              productDataModel: successState.cartItems[index],
                              cartBloc: cartBloc),
                        ),
                      ),
                    );
                  },
                ),
              ).animate(delay: const Duration(seconds: 2)).shimmer();

            // Error
            case CartErrorState:
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

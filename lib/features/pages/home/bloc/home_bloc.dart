import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cart_adding_app/data/cart_items.dart';
import 'package:cart_adding_app/data/grocery_data.dart';
import 'package:cart_adding_app/data/wishlist_items.dart';
import 'package:cart_adding_app/features/pages/home/models/home_data_product_model.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeItemDetailNavigateEvent>(homeItemDetailNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl'],
                ))
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    log("Wishlist Button clicked");
    final result = wishlistItems.contains(event.clickedProduct);
    result ? null : wishlistItems.add(event.clickedProduct);
    emit(result
        ? HomeProductWishlistAddingFailActionState()
        : HomeProductWishlistAddedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    log("Card Button clicked");
    final result = cartItems.contains(event.clickedProduct);
    result ? null : cartItems.add(event.clickedProduct);
    emit(result
        ? HomeProductCartAddingFailActionState()
        : HomeProductCartAddedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    log("Wishlist Navigate clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    log("Card Navigate clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeItemDetailNavigateEvent(
      HomeItemDetailNavigateEvent event, Emitter<HomeState> emit) {
    log("Item Detail Navigate clicked");
    emit(HomeNavigateToItemDetailPageActionState(
        clickedProduct: event.clickedProduct,
        homeBloc: event.homeBloc,
        isAddedIntoCart: event.isAddedIntoCart,
        isAddedIntoWishlist: event.isAddedIntoWishlist));
  }
}

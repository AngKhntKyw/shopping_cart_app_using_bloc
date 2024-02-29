import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cart_adding_app/data/wishlist_items.dart';
import 'package:cart_adding_app/features/pages/home/models/home_data_product_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.wishlistItem);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
    emit(WishlistRemoveFromWishlistActionState());
  }
}

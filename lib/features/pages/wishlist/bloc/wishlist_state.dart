part of 'wishlist_bloc.dart';

class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;
  WishlistSuccessState({required this.wishlistItems});
}

final class WishlistErrorState extends WishlistState {}

final class WishlistRemoveFromWishlistActionState extends WishlistActionState {}

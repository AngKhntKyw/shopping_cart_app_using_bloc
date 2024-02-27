part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductWishlistButtonClickedEvent({required this.clickedProduct});
}

final class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

final class HomeWishlistButtonNavigateEvent extends HomeEvent {}

final class HomeCartButtonNavigateEvent extends HomeEvent {}

final class HomeItemDetailNavigateEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  final HomeBloc homeBloc;
  final bool isAddedIntoCart;
  final bool isAddedIntoWishlist;
  HomeItemDetailNavigateEvent(
      {required this.clickedProduct,
      required this.homeBloc,
      required this.isAddedIntoCart,
      required this.isAddedIntoWishlist});
}

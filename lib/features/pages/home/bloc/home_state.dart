part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({
    required this.products,
  });
}

final class HomeErrorState extends HomeState {}

final class HomeNavigateToWishlistPageActionState extends HomeActionState {}

final class HomeNavigateToCartPageActionState extends HomeActionState {}

final class HomeProductWishlistAddedActionState extends HomeActionState {}

final class HomeProductCartAddedActionState extends HomeActionState {}

final class HomeProductWishlistAddingFailActionState extends HomeActionState {}

final class HomeProductCartAddingFailActionState extends HomeActionState {}

final class HomeNavigateToItemDetailPageActionState extends HomeActionState {
  final ProductDataModel clickedProduct;
  final HomeBloc homeBloc;
  final bool isAddedIntoCart;
  final bool isAddedIntoWishlist;
  HomeNavigateToItemDetailPageActionState({
    required this.clickedProduct,
    required this.homeBloc,
    required this.isAddedIntoCart,
    required this.isAddedIntoWishlist,
  });
}

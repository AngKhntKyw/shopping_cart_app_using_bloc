part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState({required this.cartItems});
}

final class CartErrorState extends CartState {}

final class CartRemoveFromCartActionState extends CartActionState {}

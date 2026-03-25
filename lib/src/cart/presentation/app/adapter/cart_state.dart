part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  const CartLoaded(this.cartItems);

  final List<CartItem> cartItems;

  @override
  List<Object?> get props => [cartItems];
}

class CartError extends CartState {
  const CartError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class CartActionLoading extends CartState {
  const CartActionLoading();
}

class CartItemAdded extends CartState {
  const CartItemAdded(this.cartItem);

  final CartItem cartItem;

  @override
  List<Object?> get props => [cartItem];
}

class CartActionSuccess extends CartState {
  const CartActionSuccess();
}

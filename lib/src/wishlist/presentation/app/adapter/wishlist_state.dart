part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded(this.products);

  final List<WishlistProduct> products;

  @override
  List<Object?> get props => [products];
}

class WishlistError extends WishlistState {
  const WishlistError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class WishlistActionLoading extends WishlistState {
  const WishlistActionLoading();
}

class WishlistActionSuccess extends WishlistState {
  const WishlistActionSuccess();
}

import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/usecases/add_to_wishlist.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/usecases/get_wishlist.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required AddToWishlist addToWishlist,
    required RemoveFromWishlist removeFromWishlist,
    required GetWishlist getWishlist,
    required UserProvider userProvider,
  }) : _addToWishlist = addToWishlist,
       _removeFromWishlist = removeFromWishlist,
       _getWishlist = getWishlist,
       _userProvider = userProvider,
       super(const WishlistInitial());

  final AddToWishlist _addToWishlist;
  final RemoveFromWishlist _removeFromWishlist;
  final GetWishlist _getWishlist;
  final UserProvider _userProvider;

  Future<void> addToWishlist(Product product) async {
    final user = _userProvider.currentUser;
    if (user == null) return;
    final oldWishlist = List<WishlistProduct>.from(user.wishList);

    final newWishlist = List<WishlistProduct>.from(oldWishlist)
      ..add(WishlistProduct.fromProduct(product));

    _userProvider.updateUser(user.copyWith(wishList: newWishlist));

    emit(const WishlistActionLoading());
    final result = await _addToWishlist(product.id);
    result.fold((failure) {
      _userProvider.updateUser(user.copyWith(wishList: oldWishlist));
      emit(WishlistError(failure.errorMessage));
    }, (_) => emit(const WishlistActionSuccess()));
  }

  Future<void> removeFromWishlist(String productId) async {
    final user = _userProvider.currentUser;
    if (user == null) return;
    final oldWishlist = List<WishlistProduct>.from(user.wishList);

    final newWishlist = List<WishlistProduct>.from(oldWishlist)
      ..removeWhere((element) => element.productId == productId);

    _userProvider.updateUser(user.copyWith(wishList: newWishlist));

    emit(const WishlistActionLoading());
    final result = await _removeFromWishlist(productId);
    result.fold((failure) {
      if (failure.statusCode != 404) {
        _userProvider.updateUser(user.copyWith(wishList: oldWishlist));
        emit(WishlistError(failure.errorMessage));
      } else {
        emit(const WishlistActionSuccess());
      }
    }, (_) => emit(const WishlistActionSuccess()));
  }

  Future<void> getWishlist() async {
    emit(const WishlistLoading());
    final result = await _getWishlist();
    result.fold((failure) => emit(WishlistError(failure.errorMessage)), (
      products,
    ) {
      if (_userProvider.currentUser != null) {
        _userProvider.updateUser(
          _userProvider.currentUser!.copyWith(wishList: products),
        );
      }
      emit(WishlistLoaded(products));
    });
  }
}

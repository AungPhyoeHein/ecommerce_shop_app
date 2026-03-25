import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/repositories/wishlist_repository.dart';

class RemoveFromWishlist extends UsecaseWithParams<void, String> {
  const RemoveFromWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  ResultFuture<void> call(String params) =>
      _repository.removeFromWishlist(params);
}

import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/repositories/wishlist_repository.dart';

class AddToWishlist extends UsecaseWithParams<void, String> {
  const AddToWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.addToWishlist(params);
}

import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlist extends UsecaseWithoutParams<List<WishlistProduct>> {
  const GetWishlist(this._repository);

  final WishlistRepository _repository;

  @override
  ResultFuture<List<WishlistProduct>> call() => _repository.getWishlist();
}

import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';

abstract class WishlistRepository {
  const WishlistRepository();

  ResultFuture<void> addToWishlist(String productId);

  ResultFuture<void> removeFromWishlist(String productId);

  ResultFuture<List<WishlistProduct>> getWishlist();
}

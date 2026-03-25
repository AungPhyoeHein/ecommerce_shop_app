import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  const CartRepository();

  ResultFuture<CartItem> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  });

  ResultFuture<List<CartItem>> getCart();

  ResultFuture<void> removeFromCart(String cartProductId);

  ResultFuture<void> modifyProductQuantity({
    required String cartProductId,
    required int quantity,
  });

  ResultFuture<int> getCartCount();
}

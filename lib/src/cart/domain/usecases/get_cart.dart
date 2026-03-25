import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';

class GetCart extends UsecaseWithoutParams<List<CartItem>> {
  const GetCart(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<List<CartItem>> call() => _repository.getCart();
}

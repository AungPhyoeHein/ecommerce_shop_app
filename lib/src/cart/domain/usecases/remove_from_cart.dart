import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';

class RemoveFromCart extends UsecaseWithParams<void, String> {
  const RemoveFromCart(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<void> call(String cartProductId) =>
      _repository.removeFromCart(cartProductId);
}

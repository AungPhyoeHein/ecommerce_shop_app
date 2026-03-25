import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';

class GetCartCount extends UsecaseWithoutParams<int> {
  const GetCartCount(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<int> call() => _repository.getCartCount();
}

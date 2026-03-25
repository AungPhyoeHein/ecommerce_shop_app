import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

class ModifyProductQuantity
    extends UsecaseWithParams<void, ModifyProductQuantityParams> {
  const ModifyProductQuantity(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<void> call(ModifyProductQuantityParams params) =>
      _repository.modifyProductQuantity(
        cartProductId: params.cartProductId,
        quantity: params.quantity,
      );
}

class ModifyProductQuantityParams extends Equatable {
  const ModifyProductQuantityParams({
    required this.cartProductId,
    required this.quantity,
  });

  final String cartProductId;
  final int quantity;

  @override
  List<Object?> get props => [cartProductId, quantity];
}

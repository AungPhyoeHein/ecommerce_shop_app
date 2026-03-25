import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

class AddToCart extends UsecaseWithParams<CartItem, AddToCartParams> {
  const AddToCart(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<CartItem> call(AddToCartParams params) => _repository.addToCart(
    productId: params.productId,
    quantity: params.quantity,
    selectedSize: params.selectedSize,
    selectedColor: params.selectedColor,
  );
}

class AddToCartParams extends Equatable {
  const AddToCartParams({
    required this.productId,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  final String productId;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  @override
  List<Object?> get props => [productId, quantity, selectedSize, selectedColor];
}

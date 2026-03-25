import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.quantity,
    super.selectedSize,
    super.selectedColor,
    required super.productExists,
    required super.productOutOfStock,
  });

  factory CartItemModel.fromMap(DataMap map) {
    return CartItemModel(
      id: map['_id'] as String,
      productId: (map['product'] is String)
          ? map['product'] as String
          : (map['product'] as DataMap)['_id'] as String,
      productName: map['productName'] as String,
      productImage: map['productImage'] as String,
      productPrice: (map['productPrice'] is num)
          ? (map['productPrice'] as num).toDouble()
          : double.parse(map['productPrice'].toString()),
      quantity: map['quantity'] as int,
      selectedSize: map['selectedSize'] as String?,
      selectedColor: map['selectedColor'] as String?,
      productExists: map['productExists'] as bool? ?? true,
      productOutOfStock: map['productOutOfStock'] as bool? ?? false,
    );
  }

  DataMap toMap() {
    return {
      '_id': id,
      'product': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'productExists': productExists,
      'productOutOfStock': productOutOfStock,
    };
  }
}

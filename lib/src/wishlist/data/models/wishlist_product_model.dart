import 'dart:convert';

import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';

class WishlistProductModel extends WishlistProduct {
  const WishlistProductModel({
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productExits,
    required super.productOutOfStock,
  });

  DataMap toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productExits': productExits,
      'productOutOfStock': productOutOfStock,
    };
  }

  factory WishlistProductModel.fromJson(String source) =>
      WishlistProductModel.fromMap(jsonDecode(source) as DataMap);

  WishlistProductModel.fromMap(DataMap map)
    : this(
        productId: map['productId'] as String,
        productName: map['productName'] as String,
        productImage: map['productImage'] as String,
        productPrice: (map['productPrice'] as num).toDouble(),
        productExits: map['productExits'] as bool,
        productOutOfStock: map['productOutOfStock'] as bool,
      );
}

import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
    required this.productExists,
    required this.productOutOfStock,
  });

  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final bool productExists;
  final bool productOutOfStock;

  @override
  List<Object?> get props => [
    id,
    productId,
    productName,
    productImage,
    productPrice,
    quantity,
    selectedSize,
    selectedColor,
    productExists,
    productOutOfStock,
  ];
}

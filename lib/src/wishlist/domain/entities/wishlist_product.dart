import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:equatable/equatable.dart';

class WishlistProduct extends Equatable {
  const WishlistProduct({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productExits,
    required this.productOutOfStock,
  });

  const WishlistProduct.empty()
    : productId = 'Test String',
      productName = 'Test String',
      productImage = 'Test String',
      productPrice = 1.0,
      productExits = true,
      productOutOfStock = false;

  factory WishlistProduct.fromProduct(Product product) {
    return WishlistProduct(
      productId: product.id,
      productName: product.name,
      productImage: product.image,
      productPrice: product.price,
      productExits: true,
      productOutOfStock: product.countInStock <= 0,
    );
  }

  Product toProduct() {
    return Product(
      id: productId,
      name: productName,
      description: '',
      price: productPrice,
      rating: 0,
      colors: const [],
      image: productImage,
      images: const [],
      reviews: const [],
      numberOfReview: 0,
      sizes: const [],
      category: const Category(id: '', name: '', color: '', image: ''),
      genderAgeCategory: null,
      countInStock: productOutOfStock ? 0 : 1,
    );
  }

  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final bool productExits;
  final bool productOutOfStock;

  @override
  List<Object?> get props => [
    productId,
    productName,
    productImage,
    productPrice,
    productExits,
    productOutOfStock,
  ];
}

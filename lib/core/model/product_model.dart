import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/model/category_model.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.rating,
    required super.colors,
    required super.image,
    required super.images,
    required super.reviews,
    required super.numberOfReview,
    required super.sizes,
    required super.category,
    required super.genderAgeCategory,
    required super.countInStock,
    super.createdAt,
    super.updatedAt,
  });

  factory ProductModel.fromMap(DataMap map) {
    final rawCategory = map['category'];
    final category = rawCategory is Map
        ? CategoryModel.fromMap(Map<String, dynamic>.from(rawCategory))
        : CategoryModel.empty((rawCategory as String?) ?? '');

    return ProductModel(
      id: ((map['_id'] ?? map['id']) as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      price: (map['price'] as num? ?? 0).toDouble(),
      rating: (map['rating'] as num? ?? 0.0).toDouble(),
      colors: List<String>.from(map['colors'] ?? []),
      image: (map['image'] as String?) ?? '',
      images: List<String>.from(map['images'] ?? []),
      reviews: List<String>.from(
        (map['reviews'] as List? ?? []).map((e) => '$e'),
      ),
      numberOfReview: (map['numberOfReview'] as num? ?? 0).toInt(),
      sizes: List<String>.from(map['sizes'] ?? []),
      category: category,
      genderAgeCategory: map['genderAgeCategory'] as String?,
      countInStock: (map['countInStock'] as num? ?? 0).toInt(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }

  DataMap toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'colors': colors,
      'image': image,
      'images': images,
      'reviews': reviews,
      'numberOfReview': numberOfReview,
      'sizes': sizes,
      'category': category.id,
      'genderAgeCategory': genderAgeCategory,
      'countInStock': countInStock,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

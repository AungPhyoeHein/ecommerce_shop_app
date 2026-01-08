import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.colors,
    required this.image,
    required this.images,
    required this.reviews,
    required this.numberOfReview,
    required this.sizes,
    required this.category,
    required this.genderAgeCategory,
    required this.countInStock,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final List<String> colors;
  final String image;
  final List<String> images;
  final List<String> reviews;
  final int numberOfReview;
  final List<String> sizes;
  final Category category;
  final String? genderAgeCategory;
  final int countInStock;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, name, category.id];
}

import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.color,
    required super.image,
    super.markedForDeletion,
    super.createdAt,
    super.updatedAt,
  });

  factory CategoryModel.fromMap(DataMap map) {
    return CategoryModel(
      id: (map['_id'] ?? map['id']) as String,
      name: map['name'] as String,
      color: map['color'] as String? ?? "#000000",
      image: map['image'] as String,
      markedForDeletion: map['markedForDeletion'] as bool? ?? false,
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
      'id': id,
      'name': name,
      'color': color,
      'image': image,
      'markedForDeletion': markedForDeletion,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CategoryModel.empty(String id) =>
      CategoryModel(id: id, name: '', color: '#000000', image: '');
}

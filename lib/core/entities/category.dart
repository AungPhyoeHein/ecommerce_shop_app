import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    this.markedForDeletion = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String color;
  final String image;
  final bool markedForDeletion;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, name, color, image, markedForDeletion];
}

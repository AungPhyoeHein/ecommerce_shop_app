import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.rating,
    super.comment,
    super.date,
    super.createdAt,
    super.updatedAt,
  });

  factory ReviewModel.fromMap(DataMap map) {
    return ReviewModel(
      id: (map['_id'] ?? map['id']) as String,
      userId: map['user'] as String,
      userName: map['userName'] as String,
      rating: (map['rating'] as num).toDouble(),
      comment: map['comment'] as String?,
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
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
      'user': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date?.toIso8601String(),
    };
  }
}

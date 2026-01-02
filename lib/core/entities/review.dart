import 'package:equatable/equatable.dart';

class Review extends Equatable {
  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String? comment;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, userId, rating, comment];
}

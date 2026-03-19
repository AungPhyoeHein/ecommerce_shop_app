import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class EditProductReview
    extends UsecaseWithParams<Review, EditProductReviewParams> {
  const EditProductReview(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<Review> call(EditProductReviewParams params) =>
      _repo.editProductReview(
        productId: params.productId,
        reviewId: params.reviewId,
        rating: params.rating,
        comment: params.comment,
      );
}

class EditProductReviewParams extends Equatable {
  const EditProductReviewParams({
    required this.productId,
    required this.reviewId,
    required this.rating,
    required this.comment,
  });
  final String productId;
  final String reviewId;
  final int rating;
  final String comment;
  @override
  List<Object> get props => [productId, reviewId, rating, comment];
}

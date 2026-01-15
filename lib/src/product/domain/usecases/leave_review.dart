import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class LeaveReview extends UsecaseWithParams<Product, LeaveReviewParams> {
  const LeaveReview(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<Product> call(LeaveReviewParams params) => _repo.leaveReview(
    productId: params.productId,
    rating: params.rating,
    comment: params.comment,
  );
}

class LeaveReviewParams extends Equatable {
  const LeaveReviewParams({
    required this.productId,
    required this.rating,
    required this.comment,
  });
  final String productId;
  final int rating;
  final String comment;

  @override
  List<Object> get props => [productId, rating, comment];
}

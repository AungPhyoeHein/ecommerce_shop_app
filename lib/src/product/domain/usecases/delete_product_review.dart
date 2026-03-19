import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteProductReview extends UsecaseWithParams {
  const DeleteProductReview(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<void> call(params) => _repo.deleteProductReview(
    productId: params.productId,
    reviewId: params.reviewId,
  );
}

class DeleteProductReviewParams extends Equatable {
  const DeleteProductReviewParams({
    required this.productId,
    required this.reviewId,
  });

  final String productId;
  final String reviewId;

  @override
  List<Object> get props => [productId, reviewId];
}

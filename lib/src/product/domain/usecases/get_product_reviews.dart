import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class GetProductReviews
    extends UsecaseWithParams<List<Review>, GetProductReviewsParams> {
  const GetProductReviews(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<List<Review>> call(GetProductReviewsParams params) =>
      _repo.getProductReviews(page: params.page, productId: params.productId);
}

class GetProductReviewsParams extends Equatable {
  const GetProductReviewsParams({required this.page, required this.productId});
  final int page;
  final String productId;
  @override
  List<Object> get props => [page, productId];
}

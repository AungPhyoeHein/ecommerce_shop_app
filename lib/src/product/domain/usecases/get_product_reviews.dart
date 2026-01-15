import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';

class GetProductReviews extends UsecaseWithParams<List<Review>, String> {
  const GetProductReviews(this._repo);

  final ProductRepository _repo;

  @override
  ResultFuture<List<Review>> call(String param) =>
      _repo.getProductReviews(param);
}

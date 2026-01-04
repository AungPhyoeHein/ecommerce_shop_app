import 'package:ecommerce_shop_app/core/entities/product.dart';
// import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class ProductRepository {
  const ProductRepository();

  ResultFuture<List<Product>> getProducts({
    required int page,
    String? category,
    String? criteria,
  });

  ResultFuture<Product> getProductById(String id);

  ResultFuture<List<Product>> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  });

  // ResultFuture<void> leaveReview({
  //   required String productId,
  //   required Review review,
  // });

  // ResultFuture<List<Review>> getProductReviews(String id);

  // ResultFuture<void> editReview({
  //   required String productId,
  //   required String reviewId,
  //   required Review review,
  // });

  // ResultFuture<void> deleteReview({
  //   required String productId,
  //   required String reviewId,
  //   required Review review,
  // });
}

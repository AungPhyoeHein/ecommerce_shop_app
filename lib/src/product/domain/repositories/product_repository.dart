import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/entities/review.dart';
// import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class ProductRepository {
  const ProductRepository();

  ResultFuture<List<Product>> getProducts({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
  });

  ResultFuture<Product> getProductById(String id);

  ResultFuture<List<Product>> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  });

  ResultFuture<Product> leaveReview({
    String productId,
    int rating,
    String comment,
  });

  ResultFuture<List<Review>> getProductReviews(String productId);

  ResultFuture<Review> editProductReview({
    String productId,
    String reviewId,
    int rating,
    String comment,
  });

  ResultFuture<void> deleteProductReview({String productId, String reviewId});
}

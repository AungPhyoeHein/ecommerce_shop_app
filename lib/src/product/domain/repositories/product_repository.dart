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
    required String productId,
    required int rating,
    required String comment,
  });

  ResultFuture<List<Review>> getProductReviews({
    required int page,
    required String productId,
  });

  ResultFuture<Review> editProductReview({
    required String productId,
    required String reviewId,
    required int rating,
    required String comment,
  });

  ResultFuture<void> deleteProductReview({
    required String productId,
    required String reviewId,
  });
}

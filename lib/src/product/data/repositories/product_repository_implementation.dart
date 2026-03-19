import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/product/data/datasource/product_data_source.dart';
import 'package:ecommerce_shop_app/src/product/domain/repositories/product_repository.dart';

class ProductRepositoryImplementation implements ProductRepository {
  ProductRepositoryImplementation(this._dataSource);

  final ProductDataSource _dataSource;

  @override
  ResultFuture<Product> getProductById(String id) async {
    try {
      final result = await _dataSource.getProductById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Product>> getProducts({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
  }) async {
    try {
      final result = await _dataSource.getProducts(
        page: page,
        category: category,
        criteria: criteria,
        isRefresh: isRefresh,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Product>> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  }) async {
    try {
      final result = await _dataSource.searchProducts(
        page: page,
        searchKey: searchKey,
        category: category,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<Product> leaveReview({
    required String productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final result = await _dataSource.leaveReview(
        productId: productId,
        rating: rating,
        comment: comment,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Review>> getProductReviews({
    required int page,
    required String productId,
  }) async {
    try {
      final result = await _dataSource.getProductReviews(
        page: page,
        productId: productId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<Review> editProductReview({
    required String productId,
    required String reviewId,
    required int rating,
    required String comment,
  }) async {
    try {
      final result = await _dataSource.editProductReview(
        productId: productId,
        reviewId: reviewId,
        rating: rating,
        comment: comment,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> deleteProductReview({
    required String productId,
    required String reviewId,
  }) async {
    try {
      final result = await _dataSource.deleteProductReview(
        productId: productId,
        reviewId: reviewId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

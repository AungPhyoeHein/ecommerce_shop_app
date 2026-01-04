import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
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
    String? category,
    String? criteria,
  }) async {
    try {
      final result = await _dataSource.getProducts(
        page: page,
        category: category,
        criteria: criteria,
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
}

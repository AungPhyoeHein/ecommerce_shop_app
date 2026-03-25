import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:ecommerce_shop_app/src/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImplementation implements WishlistRepository {
  const WishlistRepositoryImplementation(this._dataSource);

  final WishlistRemoteDataSource _dataSource;

  @override
  ResultFuture<void> addToWishlist(String productId) async {
    try {
      await _dataSource.addToWishlist(productId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> removeFromWishlist(String productId) async {
    try {
      await _dataSource.removeFromWishlist(productId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<WishlistProduct>> getWishlist() async {
    try {
      final result = await _dataSource.getWishlist();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

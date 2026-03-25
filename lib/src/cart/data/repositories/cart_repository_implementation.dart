import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_shop_app/src/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImplementation implements CartRepository {
  const CartRepositoryImplementation(this._dataSource);

  final CartRemoteDataSource _dataSource;

  @override
  ResultFuture<CartItem> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  }) async {
    try {
      final result = await _dataSource.addToCart(
        productId: productId,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<CartItem>> getCart() async {
    try {
      final result = await _dataSource.getCart();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> removeFromCart(String cartProductId) async {
    try {
      await _dataSource.removeFromCart(cartProductId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> modifyProductQuantity({
    required String cartProductId,
    required int quantity,
  }) async {
    try {
      await _dataSource.modifyProductQuantity(
        cartProductId: cartProductId,
        quantity: quantity,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> getCartCount() async {
    try {
      final result = await _dataSource.getCartCount();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

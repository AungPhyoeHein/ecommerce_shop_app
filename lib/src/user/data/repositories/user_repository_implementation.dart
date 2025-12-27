import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/user/data/datasources/user_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/user/domain/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  const UserRepositoryImplementation(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<User> getUser(String userId) async {
    try {
      final result = await _remoteDataSource.getUser(userId);
      return Right(result);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(message: error.message, statusCode: error.statusCode),
      );
    }
  }

  @override
  ResultFuture<String> getUserPaymentProfiles(String userId) async {
    try {
      final result = await _remoteDataSource.getUserPaymentProfiles(userId);
      return Right(result);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(message: error.message, statusCode: error.statusCode),
      );
    }
  }

  @override
  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final result = await _remoteDataSource.updateUser(
        userId: userId,
        updateData: updateData,
      );
      return Right(result);
    } on ServerException catch (error) {
      return Left(
        ServerFailure(message: error.message, statusCode: error.statusCode),
      );
    }
  }
}

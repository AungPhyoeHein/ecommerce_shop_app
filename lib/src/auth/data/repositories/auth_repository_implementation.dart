import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> register({
    required String name,
    required String password,
    required String email,
    required String phone,
  }) async {
    try {
      await _remoteDataSource.register(
        name: name,
        password: password,
        email: email,
        phone: phone,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      await _remoteDataSource.verifyOTP(email: email, otp: otp);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> verifyToken() async {
    try {
      final bool result = await _remoteDataSource.verifyToken();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}

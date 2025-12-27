import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> register({
    required String name,
    required String password,
    required String email,
    required String phone,
  });

  ResultFuture<User> login({required String email, required String password});

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> verifyOTP({required String email, required String otp});

  ResultFuture<void> resetPassword({
    required String email,
    required String newPassword,
  });

  ResultFuture<bool> verifyToken();
}

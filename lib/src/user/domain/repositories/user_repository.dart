import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';

abstract class UserRepository {
  const UserRepository();

  ResultFuture<User> getUser(String userId);

  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  });

  ResultFuture<String> getUserPaymentProfiles(String userId);
}

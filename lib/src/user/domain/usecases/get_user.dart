import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/user/domain/repositories/user_repository.dart';

class GetUser extends UsecaseWithParams<User, String> {
  const GetUser(this._repo);

  final UserRepository _repo;

  @override
  ResultFuture<User> call(String params) => _repo.getUser(params);
}

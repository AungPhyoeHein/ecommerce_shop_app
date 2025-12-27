import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/auth/domain/repositories/auth_repository.dart';

class VerifyToken extends UsecaseWithoutParams<void> {
  const VerifyToken(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<bool> call() => _repo.verifyToken();
}

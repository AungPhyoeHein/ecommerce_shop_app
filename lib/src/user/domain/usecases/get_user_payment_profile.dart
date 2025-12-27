import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/user/domain/repositories/user_repository.dart';

class GetUserPaymentProfile extends UsecaseWithParams<String, String> {
  const GetUserPaymentProfile(this._repo);

  final UserRepository _repo;

  @override
  ResultFuture<String> call(String params) =>
      _repo.getUserPaymentProfiles(params);
}

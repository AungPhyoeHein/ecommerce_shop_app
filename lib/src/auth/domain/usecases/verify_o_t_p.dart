import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class VerifyOTP extends UsecaseWithParams<void, VerifyOTPParams> {
  const VerifyOTP(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(VerifyOTPParams params) =>
      _repo.verifyOTP(email: params.email, otp: params.otp);
}

class VerifyOTPParams extends Equatable {
  const VerifyOTPParams({required this.email, required this.otp});

  final String email;
  final String otp;

  const VerifyOTPParams.empty() : email = 'Test String', otp = 'Test String';

  @override
  List<String> get props => [email, otp];
}

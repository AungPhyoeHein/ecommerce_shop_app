import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class Register extends UsecaseWithParams<void, RegisterParams> {
  const Register(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(RegisterParams params) {
    return _repo.register(
      name: params.name,
      password: params.password,
      email: params.email,
      phone: params.phone,
    );
  }
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  const RegisterParams.empty()
    : name = 'Test String',
      email = 'Test String',
      phone = 'Test String',
      password = 'Test String';

  final String name;
  final String email;
  final String phone;
  final String password;

  @override
  List<String> get props => [name, email, phone, password];
}

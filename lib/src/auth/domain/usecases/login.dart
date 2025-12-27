import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class Login extends UsecaseWithParams<User, LoginParams> {
  const Login(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<User> call(LoginParams params) =>
      _repo.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  const LoginParams.empty() : email = 'Test String', password = 'Test String';

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/login.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/register.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/reset_password.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/verify_o_t_p.dart';
import 'package:ecommerce_shop_app/src/auth/domain/usecases/verify_token.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required Register register,
    required Login login,
    required ForgotPassword forgotPassword,
    required VerifyOTP verifyOTP,
    required ResetPassword resetPassword,
    required VerifyToken verifyToken,
    required UserProvider userProvider,
  }) : _register = register,
       _login = login,
       _forgotPassword = forgotPassword,
       _verifyOTP = verifyOTP,
       _resetPassword = resetPassword,
       _verifyToken = verifyToken,
       _userProvider = userProvider,
       super(AuthInitial());

  final Register _register;
  final Login _login;
  final ForgotPassword _forgotPassword;
  final VerifyOTP _verifyOTP;
  final ResetPassword _resetPassword;
  final VerifyToken _verifyToken;
  final UserProvider _userProvider;

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _register.call(
      RegisterParams(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const Registered()),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _login.call(
      LoginParams(email: email, password: password),
    );
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (user) {
      _userProvider.setUser(user);
      emit(LoggedIn(user));
    });
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoading());
    final result = await _forgotPassword.call(email);
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const OTPSent()),
    );
  }

  Future<void> verifyOTP({required String email, required String otp}) async {
    emit(const AuthLoading());

    final result = await _verifyOTP(VerifyOTPParams(email: email, otp: otp));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const OTPVerified()),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(const AuthLoading());

    final result = await _resetPassword.call(
      ResetPasswordParams(email: email, newPassword: newPassword),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const PasswordReset()),
    );
  }

  Future<void> verifyToken() async {
    emit(const AuthLoading());

    final result = await _verifyToken.call();
    result.fold((failure) => emit(AuthError(failure.errorMessage)), (isValid) {
      emit(TokenVerified(isValid));
      if (!isValid) _userProvider.setUser(null);
    });
  }
}

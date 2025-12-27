part of 'auth_user_cubit.dart';

sealed class AuthUserState extends Equatable {
  const AuthUserState();

  @override
  List<Object> get props => [];
}

//THE INITIAL STATE
final class AuthUserInitial extends AuthUserState {
  const AuthUserInitial();
}

//THE LOADING STATES
final class GettingUserData extends AuthUserState {
  const GettingUserData();
}

final class UpdatingUserData extends AuthUserState {
  const UpdatingUserData();
}

final class GettingUserPaymentProfile extends AuthUserState {
  const GettingUserPaymentProfile();
}

//THE SUCCESS STATES
final class GotUserData extends AuthUserState {
  const GotUserData(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

final class UpdatedUserData extends AuthUserState {
  const UpdatedUserData(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

final class GotUserPaymentProfile extends AuthUserState {
  const GotUserPaymentProfile(this.paymentProfileUrl);

  final String paymentProfileUrl;

  @override
  List<Object> get props => [paymentProfileUrl];
}

//THE ERROR STATE
final class AuthUserError extends AuthUserState {
  const AuthUserError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

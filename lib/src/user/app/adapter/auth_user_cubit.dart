import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/user/domain/usecases/get_user.dart';
import 'package:ecommerce_shop_app/src/user/domain/usecases/get_user_payment_profile.dart';
import 'package:ecommerce_shop_app/src/user/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  AuthUserCubit({
    required GetUser getUser,
    required GetUserPaymentProfile getUserPaymentProfile,
    required UpdateUser updateUser,
    required UserProvider userProvider,
  }) : _getUser = getUser,
       _getUserPaymentProfile = getUserPaymentProfile,
       _updateUser = updateUser,
       userProvider = userProvider,
       super(const AuthUserInitial());

  final GetUser _getUser;
  final GetUserPaymentProfile _getUserPaymentProfile;
  final UpdateUser _updateUser;
  final UserProvider userProvider;

  Future<void> getUserById(String userId) async {
    emit(const GettingUserData());

    final result = await _getUser(userId);

    result.fold((failure) => emit(AuthUserError(failure.errorMessage)), (user) {
      userProvider.setUser(user);
      emit(GotUserData(user));
    });
  }

  Future<void> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    emit(const UpdatingUserData());

    final result = await _updateUser(
      UpdateUserParams(userId: userId, updateData: updateData),
    );

    result.fold((failure) => emit(AuthUserError(failure.errorMessage)), (user) {
      userProvider.updateUser(user);
      emit(GotUserData(user));
    });
  }

  Future<void> getUserPaymentProfile(String userId) async {
    emit(const GettingUserPaymentProfile());

    final result = await _getUserPaymentProfile(userId);

    result.fold(
      (failure) => emit(AuthUserError(failure.errorMessage)),
      (paymentProfileUrl) => emit(GotUserPaymentProfile(paymentProfileUrl)),
    );
  }
}

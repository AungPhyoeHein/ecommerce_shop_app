import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/user/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParams<User, UpdateUserParams> {
  const UpdateUser(this._repo);

  final UserRepository _repo;

  @override
  ResultFuture<User> call(UpdateUserParams params) =>
      _repo.updateUser(userId: params.userId, updateData: params.updateData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.userId, required this.updateData});

  final String userId;
  final DataMap updateData;

  @override
  List<Object?> get props => [userId, updateData];
}

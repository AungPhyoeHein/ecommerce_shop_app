import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/repositories/chat_repository.dart';

class ClearCachedMessages extends UsecaseWithoutParams<void> {
  const ClearCachedMessages(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<void> call() => _repository.clearCachedMessages();
}

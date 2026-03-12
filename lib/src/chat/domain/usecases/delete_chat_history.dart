import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/repositories/chat_repository.dart';

class DeleteChatHistory extends UsecaseWithoutParams<void> {
  const DeleteChatHistory(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<void> call() => _repository.deleteChatHistory();
}

import 'package:ecommerce_shop_app/core/usecase/usecase.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:ecommerce_shop_app/src/chat/domain/repositories/chat_repository.dart';

class GetCachedMessages extends UsecaseWithoutParams<List<ChatMessage>> {
  const GetCachedMessages(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<List<ChatMessage>> call() => _repository.getCachedMessages();
}

import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  const ChatRepository();

  ResultFuture<ChatMessage> sendMessage(String message);
  ResultFuture<List<ChatMessage>> getCachedMessages();
  ResultFuture<void> clearCachedMessages();
}

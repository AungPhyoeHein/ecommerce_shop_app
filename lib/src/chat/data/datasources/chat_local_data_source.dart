import 'dart:convert';

import 'package:ecommerce_shop_app/core/model/product_model.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatLocalDataSource {
  const ChatLocalDataSource();

  Future<void> cacheMessages(List<ChatMessage> messages);
  Future<List<ChatMessage>> getMessages();
  Future<void> clearMessages();
}

const CACHED_MESSAGES = 'CACHED_MESSAGES';

class ChatLocalDataSourceImplementation implements ChatLocalDataSource {
  const ChatLocalDataSourceImplementation(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheMessages(List<ChatMessage> messages) async {
    final List<String> messagesJson = messages.map((m) {
      return jsonEncode({
        'id': m.id,
        'message': m.message,
        'type': m.type.name,
        'responseType': m.responseType.name,
        'timestamp': m.timestamp?.toIso8601String(),
        'products': m.products != null
            ? m.products!.map((p) => (p as ProductModel).toMap()).toList()
            : null,
      });
    }).toList();
    await _prefs.setStringList(CACHED_MESSAGES, messagesJson);
  }

  @override
  Future<List<ChatMessage>> getMessages() async {
    final List<String>? messagesJson = _prefs.getStringList(CACHED_MESSAGES);
    if (messagesJson == null) return [];

    return messagesJson.map((json) {
      final map = jsonDecode(json);
      return ChatMessage(
        id: map['id'],
        message: map['message'],
        type: ChatMessageType.values.byName(map['type']),
        responseType: ChatResponseType.values.byName(map['responseType']),
        timestamp: map['timestamp'] != null
            ? DateTime.parse(map['timestamp'])
            : null,
        products: map['products'] != null
            ? (map['products'] as List)
                  .map((p) => ProductModel.fromMap(p as DataMap))
                  .toList()
            : null,
      );
    }).toList();
  }

  @override
  Future<void> clearMessages() async {
    await _prefs.remove(CACHED_MESSAGES);
  }
}

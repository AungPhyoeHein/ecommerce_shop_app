import 'package:ecommerce_shop_app/core/model/product_model.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.message,
    required super.type,
    super.responseType,
    super.products,
    super.timestamp,
  });

  factory ChatMessageModel.fromMap(DataMap map, ChatMessageType type) {
    ChatResponseType responseType = ChatResponseType.text;
    if (map['type'] == 'faq') {
      responseType = ChatResponseType.faq;
    } else if (map['type'] == 'products') {
      responseType = ChatResponseType.products;
    }

    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Generating a temporary ID
      message: map['message'] as String? ?? map['response'] as String? ?? map['response_text'] as String? ?? '',
      type: type,
      responseType: responseType,
      products: map['data'] != null
          ? (map['data'] as List)
              .map((e) => ProductModel.fromMap(e as DataMap))
              .toList()
          : null,
      timestamp: DateTime.now(),
    );
  }

  ChatMessageModel copyWith({
    String? id,
    String? message,
    ChatMessageType? type,
    ChatResponseType? responseType,
    List<ProductModel>? products,
    DateTime? timestamp,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      responseType: responseType ?? this.responseType,
      products: products ?? this.products,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

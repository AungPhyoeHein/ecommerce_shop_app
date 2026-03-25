import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:equatable/equatable.dart';

enum ChatMessageType { user, ai }

enum ChatResponseType { text, faq, products, recommend }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.message,
    required this.type,
    this.responseType = ChatResponseType.text,
    this.products,
    this.timestamp,
  });

  final String id;
  final String message;
  final ChatMessageType type;
  final ChatResponseType responseType;
  final List<Product>? products;
  final DateTime? timestamp;

  @override
  List<Object?> get props => [
    id,
    message,
    type,
    responseType,
    products,
    timestamp,
  ];
}

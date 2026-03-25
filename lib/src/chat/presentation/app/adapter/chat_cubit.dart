import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/clear_cached_messages.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/delete_chat_history.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/get_cached_messages.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/send_message.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required SendMessage sendMessage,
    required GetCachedMessages getCachedMessages,
    required ClearCachedMessages clearCachedMessages,
    required DeleteChatHistory deleteChatHistory,
  }) : _sendMessage = sendMessage,
       _getCachedMessages = getCachedMessages,
       _clearCachedMessages = clearCachedMessages,
       _deleteChatHistory = deleteChatHistory,
       super(const ChatInitial());

  final SendMessage _sendMessage;
  final GetCachedMessages _getCachedMessages;
  final ClearCachedMessages _clearCachedMessages;
  final DeleteChatHistory _deleteChatHistory;

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  Future<void> getMessages() async {
    emit(const ChatLoading());
    final result = await _getCachedMessages();

    result.fold((failure) => emit(ChatError(failure.errorMessage)), (messages) {
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatMessagesUpdated(List.from(_messages)));
    });
  }

  Future<void> clearMessages() async {
    emit(const ChatLoading());
    final result = await _clearCachedMessages();

    result.fold((failure) => emit(ChatError(failure.errorMessage)), (_) {
      _messages.clear();
      emit(const ChatMessagesUpdated([]));
    });
  }

  Future<void> deleteChatHistory() async {
    emit(const ChatLoading());
    final result = await _deleteChatHistory();

    result.fold((failure) => emit(ChatError(failure.errorMessage)), (_) {
      _messages.clear();
      emit(const ChatHistoryDeleted());
      emit(const ChatMessagesUpdated([]));
    });
  }

  Future<void> sendMessage(String message) async {
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      type: ChatMessageType.user,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    emit(ChatMessagesUpdated(List.from(_messages)));
    emit(const ChatLoading());

    final result = await _sendMessage(message);

    result.fold(
      (failure) {
        emit(ChatError(failure.errorMessage));
        emit(ChatMessagesUpdated(List.from(_messages)));
      },
      (aiMessage) {
        _messages.add(aiMessage);
        emit(ChatMessagesUpdated(List.from(_messages)));
      },
    );
  }
}

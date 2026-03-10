import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/clear_cached_messages.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/get_cached_messages.dart';
import 'package:ecommerce_shop_app/src/chat/domain/usecases/send_message.dart';
import 'package:ecommerce_shop_app/src/chat/presentation/app/adapter/chat_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSendMessage extends Mock implements SendMessage {}
class MockGetCachedMessages extends Mock implements GetCachedMessages {}
class MockClearCachedMessages extends Mock implements ClearCachedMessages {}

void main() {
  late SendMessage sendMessage;
  late GetCachedMessages getCachedMessages;
  late ClearCachedMessages clearCachedMessages;
  late ChatCubit chatCubit;

  const tMessage = 'Hello AI';
  final tAiResponse = ChatMessage(
    id: '1',
    message: 'Hello Human',
    type: ChatMessageType.ai,
    timestamp: DateTime.now(),
  );

  final tFailure = ServerFailure(message: 'Server Error', statusCode: 500);

  setUp(() {
    sendMessage = MockSendMessage();
    getCachedMessages = MockGetCachedMessages();
    clearCachedMessages = MockClearCachedMessages();
    chatCubit = ChatCubit(
      sendMessage: sendMessage,
      getCachedMessages: getCachedMessages,
      clearCachedMessages: clearCachedMessages,
    );
  });

  tearDown(() {
    chatCubit.close();
  });

  test('initial state should be ChatInitial', () {
    expect(chatCubit.state, const ChatInitial());
  });

  group('sendMessage', () {
    blocTest<ChatCubit, ChatState>(
      'should emit [ChatMessagesUpdated, ChatLoading, ChatMessagesUpdated] when successful',
      build: () {
        when(() => sendMessage(any())).thenAnswer((_) async => Right(tAiResponse));
        return chatCubit;
      },
      act: (cubit) => cubit.sendMessage(tMessage),
      expect: () => [
        isA<ChatMessagesUpdated>(),
        const ChatLoading(),
        isA<ChatMessagesUpdated>(),
      ],
      verify: (_) {
        verify(() => sendMessage(tMessage)).called(1);
      },
    );

    blocTest<ChatCubit, ChatState>(
      'should emit [ChatMessagesUpdated, ChatLoading, ChatError, ChatMessagesUpdated] when unsuccessful',
      build: () {
        when(() => sendMessage(any())).thenAnswer((_) async => Left(tFailure));
        return chatCubit;
      },
      act: (cubit) => cubit.sendMessage(tMessage),
      expect: () => [
        isA<ChatMessagesUpdated>(),
        const ChatLoading(),
        ChatError(tFailure.errorMessage),
        isA<ChatMessagesUpdated>(),
      ],
      verify: (_) {
        verify(() => sendMessage(tMessage)).called(1);
      },
    );
  });
}

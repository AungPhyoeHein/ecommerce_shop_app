import 'package:dartz/dartz.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/data/datasources/chat_local_data_source.dart';
import 'package:ecommerce_shop_app/src/chat/data/datasources/chat_remote_data_source.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:ecommerce_shop_app/src/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImplementation implements ChatRepository {
  const ChatRepositoryImplementation(this._remoteDataSource, this._localDataSource);

  final ChatRemoteDataSource _remoteDataSource;
  final ChatLocalDataSource _localDataSource;

  @override
  ResultFuture<ChatMessage> sendMessage(String message) async {
    try {
      final result = await _remoteDataSource.sendMessage(message);
      final currentMessages = await _localDataSource.getMessages();
      
      final userMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        type: ChatMessageType.user,
        timestamp: DateTime.now(),
      );
      
      currentMessages.add(userMessage);
      currentMessages.add(result);
      await _localDataSource.cacheMessages(currentMessages);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ChatMessage>> getCachedMessages() async {
    try {
      final remoteMessages = await _remoteDataSource.getChatHistory();
      await _localDataSource.cacheMessages(remoteMessages);
      return Right(remoteMessages);
    } on ServerException catch (e) {
      try {
        final localMessages = await _localDataSource.getMessages();
        return Right(localMessages);
      } catch (_) {
        return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
      }
    } catch (e) {
      try {
        final localMessages = await _localDataSource.getMessages();
        return Right(localMessages);
      } catch (_) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  ResultFuture<void> clearCachedMessages() async {
    try {
      await _localDataSource.clearMessages();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteChatHistory() async {
    try {
      await _remoteDataSource.deleteChatHistory();
      await _localDataSource.clearMessages();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}

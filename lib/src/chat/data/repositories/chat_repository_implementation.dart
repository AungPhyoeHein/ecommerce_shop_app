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
      final result = await _localDataSource.getMessages();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  ResultFuture<void> clearCachedMessages() async {
    try {
      await _localDataSource.clearMessages();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), statusCode: 500));
    }
  }
}

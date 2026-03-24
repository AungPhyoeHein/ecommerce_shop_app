import 'dart:convert';

import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/chat/data/models/chat_message_model.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  const ChatRemoteDataSource();

  Future<ChatMessageModel> sendMessage(String message);
  Future<List<ChatMessageModel>> getChatHistory();
  Future<void> deleteChatHistory();
}

const ASSISTANT_ENDPOINT = '/assistant';
const CHAT_HISTORY_ENDPOINT = '/assistant/history';

class ChatRemoteDataSourceImplementation implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<ChatMessageModel> sendMessage(String message) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$ASSISTANT_ENDPOINT').replace(
        queryParameters: {'message': message},
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(utf8.decode(response.bodyBytes));

      // Handle both 200 (success) and 404 (valid AI "not found" response)
      if (response.statusCode != 200 && response.statusCode != 404) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      if (payload is! DataMap) {
        throw ServerException(
          message: 'Expected a message map but got something else.',
          statusCode: 500,
        );
      }

      return ChatMessageModel.fromMap(payload, ChatMessageType.ai);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatHistory() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$CHAT_HISTORY_ENDPOINT');

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      if (payload is! DataMap) {
        throw ServerException(
          message: 'Expected a history map but got something else.',
          statusCode: 500,
        );
      }

      final messagesList = payload['messages'] as List<dynamic>? ?? [];
      return messagesList.map((msg) {
        final map = msg as DataMap;
        final role = map['role'] as String?;
        final type = role == 'ai' ? ChatMessageType.ai : ChatMessageType.user;
        return ChatMessageModel.fromMap(map, type);
      }).toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> deleteChatHistory() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$CHAT_HISTORY_ENDPOINT');

      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }
}

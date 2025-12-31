import 'dart:convert';

import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/errors/failures.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/model/user_model.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/network_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  const UserRemoteDataSource();

  Future<User> getUser(String userId);

  Future<String> getUserPaymentProfiles(String userId);

  Future<User> updateUser({
    required String userId,
    required DataMap updateData,
  });
}

const USERS_ENDPOINT = '/users';

class UserRemoteDataSourceImplementation implements UserRemoteDataSource {
  const UserRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId',
      );
      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault,it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> getUserPaymentProfiles(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/$USERS_ENDPOINT/$userId/payment-profile',
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerFailure(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return payload['url'] as String;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault,it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<User> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/$USERS_ENDPOINT/$userId',
      );

      final response = await _client.patch(
        uri,
        body: jsonEncode(updateData),
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerFailure(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: It\'s not your fault,it\'s ours',
        statusCode: 500,
      );
    }
  }
}

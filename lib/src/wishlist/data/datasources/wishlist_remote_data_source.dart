import 'dart:convert';

import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/network_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/wishlist/data/models/wishlist_product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  const WishlistRemoteDataSource();

  Future<void> addToWishlist(String productId);

  Future<void> removeFromWishlist(String productId);

  Future<List<WishlistProductModel>> getWishlist();
}

const WISHLIST_ENDPOINT = '/users/wishlist';

class WishlistRemoteDataSourceImplementation
    implements WishlistRemoteDataSource {
  const WishlistRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<void> addToWishlist(String productId) async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/wishlist',
      );
      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
        body: jsonEncode({'productId': productId}),
      );
      final payload = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : <String, dynamic>{};
      await NetworkUtils.renewToken(response);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final errorResponse = ErrorResponse.fromMap(
          Map<String, dynamic>.from(payload as Map),
        );
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
      throw const ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/wishlist',
      );
      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
        body: jsonEncode({'productId': productId}),
      );
      final payload = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : <String, dynamic>{};
      await NetworkUtils.renewToken(response);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final errorResponse = ErrorResponse.fromMap(
          Map<String, dynamic>.from(payload as Map),
        );
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
      throw const ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<WishlistProductModel>> getWishlist() async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/wishlist',
      );
      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );
      final payload = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : <dynamic>[];
      await NetworkUtils.renewToken(response);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final errorResponse = ErrorResponse.fromMap(
          Map<String, dynamic>.from(payload as Map),
        );
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return (payload as List)
          .map(
            (product) => WishlistProductModel.fromMap(
              Map<String, dynamic>.from(product as Map),
            ),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message: 'Error Occurred: It\'s not your fault, it\'s ours',
        statusCode: 500,
      );
    }
  }
}

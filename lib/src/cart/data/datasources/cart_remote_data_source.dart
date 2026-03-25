import 'dart:convert';

import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/network_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:ecommerce_shop_app/src/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  const CartRemoteDataSource();

  Future<CartItemModel> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  });

  Future<List<CartItemModel>> getCart();

  Future<void> removeFromCart(String cartProductId);

  Future<void> modifyProductQuantity({
    required String cartProductId,
    required int quantity,
  });

  Future<int> getCartCount();
}

class CartRemoteDataSourceImplementation implements CartRemoteDataSource {
  const CartRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<CartItemModel> addToCart({
    required String productId,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  }) async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse('${NetworkConstants.baseUrl}/users/$userId/cart');
      final response = await _client.post(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
          'selectedSize': selectedSize,
          'selectedColor': selectedColor,
        }),
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
      return CartItemModel.fromMap(payload as DataMap);
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
  Future<List<CartItemModel>> getCart() async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse('${NetworkConstants.baseUrl}/users/$userId/cart');
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
          .map((item) => CartItemModel.fromMap(item as DataMap))
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

  @override
  Future<void> removeFromCart(String cartProductId) async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/cart/$cartProductId',
      );
      final response = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
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
  Future<void> modifyProductQuantity({
    required String cartProductId,
    required int quantity,
  }) async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/cart/$cartProductId',
      );
      final response = await _client.put(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
        body: jsonEncode({'quantity': quantity}),
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
  Future<int> getCartCount() async {
    try {
      final userId = Cache.instance.userId;
      if (userId == null) {
        throw const ServerException(
          message: 'User is not logged in',
          statusCode: 401,
        );
      }
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/users/$userId/cart/count',
      );
      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
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
      return (payload as Map)['cartCount'] as int;
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

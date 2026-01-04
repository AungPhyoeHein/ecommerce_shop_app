import 'dart:convert';
import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/model/category_model.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/network_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  const CategoryRemoteDataSource();

  Future<List<CategoryModel>> getCategories();
}

const CATEGORIES_ENDPOINT = "/categories";

class CategoryRemoteDataSourceImplementation
    implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImplementation(this._client);
  final http.Client _client;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$CATEGORIES_ENDPOINT');
      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      await NetworkUtils.renewToken(response);
      final payload = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> data = payload as List<dynamic>;

      return data
          .map((category) => CategoryModel.fromMap(category as DataMap))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Error Occurred: \'s not your fault,it\'s ours',
        statusCode: 500,
      );
    }
  }
}

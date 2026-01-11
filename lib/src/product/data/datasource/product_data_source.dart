import 'dart:convert';

import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/model/product_model.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:ecommerce_shop_app/core/utils/error_response.dart';
import 'package:ecommerce_shop_app/core/utils/network_utils.dart';
import 'package:ecommerce_shop_app/core/utils/typedef.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class ProductDataSource {
  const ProductDataSource();

  Future<List<Product>> getProducts({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
  });

  Future<Product> getProductById(String id);

  Future<List<Product>> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  });
}

const GET_PRODUCTS = "/products";
const SEARCH_PRODUCTS = "/products/search";

class ProductDataSourceImplementation implements ProductDataSource {
  ProductDataSourceImplementation(this._client);

  String? _lastCategory;
  final List<ProductModel> _filteredProducts = [];
  final List<ProductModel> _products = [];
  final List<ProductModel> _popularProducts = [];

  final http.Client _client;

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final uri = Uri.parse("${NetworkConstants.baseUrl}$GET_PRODUCTS/$id");

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      await NetworkUtils.renewToken(response);
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return ProductModel.fromMap(payload);
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

  @override
  Future<List<ProductModel>> getProducts({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
  }) async {
    try {
      if (page == 1 && !isRefresh) {
        if (criteria == "popular" && _popularProducts.isNotEmpty) {
          return _popularProducts;
        }
        if (category != null && _filteredProducts.isNotEmpty) {
          return _filteredProducts;
        }
        if (category == null && criteria == null && _products.isNotEmpty) {
          return _products;
        }
      }

      final uri = Uri.parse("${NetworkConstants.baseUrl}$GET_PRODUCTS").replace(
        queryParameters: {
          'page': page.toString(),
          if (category != null) 'category': category,
          if (criteria != null) 'criteria': criteria,
        },
      );

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

      final data = payload as List;

      return _checkAndReturnProduct(
        products: data
            .map((product) => ProductModel.fromMap(product as DataMap))
            .toList(),
        isRefresh: isRefresh,
        page: page,
        criteria: criteria,
        category: category,
      );
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

  @override
  Future<List<ProductModel>> searchProducts({
    required int page,
    String? searchKey,
    String? category,
  }) async {
    try {
      if (page == 1) {
        if (category != null ||
            (_lastCategory != null && _lastCategory == category)) {
          return _filteredProducts;
        }
        if (category == null) {
          return _products;
        }
      }
      final uri = Uri.parse("${NetworkConstants.baseUrl}$SEARCH_PRODUCTS")
          .replace(
            queryParameters: {
              'page': page.toString(),
              if (category != null) 'category': category,
              if (searchKey != null) 'search': searchKey,
            },
          );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      final data = payload as List;

      return _checkAndReturnProduct(
        products: data
            .map((product) => ProductModel.fromMap(product as DataMap))
            .toList(),
        isRefresh: false,
        page: page,
      );
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

  List<ProductModel> _checkAndReturnProduct({
    required int page,
    required bool isRefresh,
    String? category,
    String? criteria,
    required List<ProductModel> products,
  }) {
    if (criteria == "popular") {
      if (page == 1 && isRefresh) _popularProducts.clear();
      _popularProducts.addAll(products);
      return _popularProducts;
    }

    if (category != null) {
      if (isRefresh || _lastCategory != category) {
        _filteredProducts.clear();
        _lastCategory = category;
      }
      _filteredProducts.addAll(products);
      return _filteredProducts;
    }

    if (category == null && criteria == null) {
      if (page == 1 || isRefresh) _products.clear();
      _products.addAll(products);
      return _products;
    }

    return products;
  }
}

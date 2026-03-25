import 'dart:convert';
import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/entities/review.dart';
import 'package:ecommerce_shop_app/core/errors/exception.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/model/product_model.dart';
import 'package:ecommerce_shop_app/core/model/review_model.dart';
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

  Future<Product> leaveReview({
    required String productId,
    required int rating,
    required String comment,
  });

  Future<List<Review>> getProductReviews({
    required int page,
    required String productId,
  });

  Future<Review> editProductReview({
    required String productId,
    required String reviewId,
    required int rating,
    required String comment,
  });

  Future<void> deleteProductReview({
    required String productId,
    required String reviewId,
  });
}

const GET_PRODUCTS_ENDPOINT = "/products";
const SEARCH_PRODUCTS_ENDPOINT = "/products/search";
const REVIEW_ENDPOINT = "/reviews";

class ProductDataSourceImplementation implements ProductDataSource {
  ProductDataSourceImplementation(this._client);

  String? _lastCategory;
  final List<ProductModel> _filteredProducts = [];
  final List<ProductModel> _products = [];
  final List<ProductModel> _popularProducts = [];

  //Review Data
  int? _reviewPage;
  String? _reviewProductId;
  final List<ReviewModel> _reviews = [];

  final http.Client _client;

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final uri = Uri.parse(
        "${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$id",
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
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

      if (payload is! DataMap) {
        throw ServerException(
          message: 'Expected a product map but got something else.',
          statusCode: 500,
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

      final uri = Uri.parse("${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT")
          .replace(
            queryParameters: {
              'page': page.toString(),
              if (category != null) 'category': category,
              if (criteria != null) 'criteria': criteria,
            },
          );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
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
      final uri =
          Uri.parse(
            "${NetworkConstants.baseUrl}$SEARCH_PRODUCTS_ENDPOINT",
          ).replace(
            queryParameters: {
              'page': page.toString(),
              if (category != null) 'category': category,
              if (searchKey != null) 'search': searchKey,
            },
          );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
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

  @override
  Future<ProductModel> leaveReview({
    required String productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final uri = Uri.parse(
        "${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$productId$REVIEW_ENDPOINT",
      );
      final result = await _client.post(
        uri,
        body: jsonEncode({"rating": rating, "comment": comment}),
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(result.body);

      if (result.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: result.statusCode,
        );
      }

      if (payload is! DataMap) {
        throw ServerException(
          message: 'Expected a product map but got something else.',
          statusCode: 500,
        );
      }

      _reviews.clear();
      await getProductReviews(page: _reviewPage ?? 1, productId: productId);

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
  Future<List<ReviewModel>> getProductReviews({
    required int page,
    required String productId,
  }) async {
    if (page == 1) {
      if (_reviewProductId == productId && _reviews.isNotEmpty) {
        return _reviews;
      }
      _reviewProductId = productId;
      _reviews.clear();
    }

    try {
      final uri = Uri.parse(
        "${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$productId$REVIEW_ENDPOINT",
      );
      final result = await _client.get(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(result.body);

      if (result.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: result.statusCode,
        );
      }

      if (payload is! List) {
        throw ServerException(
          message: 'Expected a list of reviews but got something else.',
          statusCode: 500,
        );
      }

      _reviews.addAll(
        payload
            .map((review) => ReviewModel.fromMap(review as DataMap))
            .toList(),
      );
      _reviewPage = page;

      return _reviews;
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
  Future<ReviewModel> editProductReview({
    required String productId,
    required String reviewId,
    required int rating,
    required String comment,
  }) async {
    try {
      final uri = Uri.parse(
        "${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$productId$REVIEW_ENDPOINT/$reviewId",
      );
      final result = await _client.patch(
        uri,
        body: jsonEncode({"rating": rating, "comment": comment}),
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(result.body);
      if (result.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload as DataMap);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: result.statusCode,
        );
      }

      // if (payload is! DataMap) {
      //   throw ServerException(
      //     message: 'Expected a review map but got something else.',
      //     statusCode: 500,
      //   );
      // }

      return ReviewModel.fromMap(payload as DataMap);
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
  Future<void> deleteProductReview({
    required String productId,
    required String reviewId,
  }) async {
    try {
      final uri = Uri.parse(
        "${NetworkConstants.baseUrl}$GET_PRODUCTS_ENDPOINT/$productId$REVIEW_ENDPOINT/$reviewId",
      );

      final result = await _client.delete(
        uri,
        headers: Cache.instance.sessionToken?.toAuthHeaders,
      );

      final payload = jsonDecode(result.body) as DataMap;
      if (result.statusCode != 204) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: result.statusCode,
        );
      }
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

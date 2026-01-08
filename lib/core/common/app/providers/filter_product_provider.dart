import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:flutter/material.dart';

class FilterProductProvider extends ChangeNotifier {
  FilterProductProvider._internal();

  static final instance = FilterProductProvider._internal();
  int _currentPage = 1;
  bool _isEnd = false;
  String? _selectedCategory;
  List<Product>? _filterProduct;

  List<Product>? get filterProduct => _filterProduct;
  bool get isEnd => _isEnd;
  int get currentPage => _currentPage;
  String? get category => _selectedCategory;

  void addFilterProduct(List<Product> products, String category) {
    _selectedCategory = category;
    if (_filterProduct == null || _filterProduct!.isEmpty) {
      _filterProduct = products;
    } else {
      _filterProduct!.addAll(products);
    }

    if (products.length < NetworkConstants.pageSize) {
      _isEnd = true;
    }

    notifyListeners();
  }

  void nextPage() {
    _currentPage++;
  }

  void clearFilterProductList() {
    _currentPage = 1;
    _isEnd = false;
    _filterProduct = null;
    _selectedCategory = null;
    notifyListeners();
  }
}

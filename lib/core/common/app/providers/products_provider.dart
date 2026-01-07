import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:flutter/widgets.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider._internal();
  static final instance = ProductsProvider._internal();

  int _currentPage = 1;
  List<Product>? _products;
  List<Product>? get products => _products;
  bool _isEnd = false;

  int get currentPage => _currentPage;

  bool get isEnd => _isEnd;

  void addProductList(List<Product> products) {
    if (_products == null || _products!.isEmpty) {
      _products = products;
    } else {
      _products!.addAll(products);
    }

    if (products.length < NetworkConstants.pageSize) {
      _isEnd = true;
    } else {
      _currentPage++;
    }

    notifyListeners();
  }

  void clearProductList() {
    _currentPage = 1;
    _isEnd = false;
    _products = [];
    notifyListeners();
  }
}

import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/utils/constants/network_constants.dart';
import 'package:flutter/widgets.dart';

class PopularProductProvider extends ChangeNotifier {
  PopularProductProvider._internal();
  static final instance = PopularProductProvider._internal();

  int _currentPage = 1;
  List<Product>? _products;
  List<Product>? get popularProduct => _products;
  bool _isEnd = false;

  int get currentPage => _currentPage;

  bool get isEnd => _isEnd;

  // void setPopularProductList(List<Product> popularProducts) {
  //   _products = popularProducts;
  //   notifyListeners();
  // }

  void addPopularProductList(List<Product> popularProducts) {
    if (_products == null || _products!.isEmpty) {
      _products = popularProducts;
    } else {
      _products!.addAll(popularProducts);
    }

    if (popularProducts.length < NetworkConstants.pageSize) {
      _isEnd = true;
    } else {
      _currentPage++;
    }

    notifyListeners();
  }

  void clearPopularProductList() {
    _currentPage = 1;
    _isEnd = false;
    _products = [];
    notifyListeners();
  }
}

import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider._internal();

  static final instance = CategoryProvider._internal();

  List<Category>? _categories;

  List<Category>? get categories => _categories;

  void addCategories(List<Category> categories) {
    _categories = categories;
    notifyListeners();
  }

  void clearCategories() {
    _categories = null;
    notifyListeners();
  }
}

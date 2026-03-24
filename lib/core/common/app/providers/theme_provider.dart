import 'package:ecommerce_shop_app/core/common/app/cache_helper.dart';
import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._cacheHelper) {
    _themeMode = _cacheHelper.getThemeMode();
  }

  final CacheHelper _cacheHelper;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (_themeMode != themeMode) {
      _themeMode = themeMode;
      await _cacheHelper.cacheThemeMode(themeMode);
      Cache.instance.setThemeMode(themeMode);
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}

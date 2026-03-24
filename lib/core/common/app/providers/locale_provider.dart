import 'package:ecommerce_shop_app/core/common/app/cache_helper.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._cacheHelper) {
    final code = _cacheHelper.getLanguageCode();
    _locale = code != null ? Locale(code) : const Locale('en');
  }

  final CacheHelper _cacheHelper;
  late Locale _locale;

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      await _cacheHelper.cacheLanguageCode(locale.languageCode);
      notifyListeners();
    }
  }
}

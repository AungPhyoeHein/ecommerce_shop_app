import 'package:ecommerce_shop_app/core/common/singletons/cache.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _sessionTokenKey = 'user-session-token';
  static const _userIdKey = 'user-id';
  static const _themeModeKey = 'theme-mode';
  static const _firstTimerKey = 'is-user-first-timer';

  Future<bool> cacheSessionToken(String token) async {
    try {
      final result = await _prefs.setString(_sessionTokenKey, token);
      Cache.instance.setSessionToken(token);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _prefs.setString(_userIdKey, userId);
      Cache.instance.setUserId(userId);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }

  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    try {
      await _prefs.setString(_themeModeKey, themeMode.stringValue);
      Cache.instance.setThemeMode(themeMode);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  String? getSessionToken() {
    final sessionToken = _prefs.getString(_sessionTokenKey);
    if (sessionToken case String()) {
      Cache.instance.setSessionToken(sessionToken);
    } else {
      debugPrint('getSessionToken: session does not exit');
    }
    return sessionToken;
  }

  String? getUserId() {
    final userId = _prefs.getString(_userIdKey);
    if (userId case String()) {
      Cache.instance.setUserId(userId);
    }
    return userId;
  }

  ThemeMode getThemeMode() {
    final themeModeStringValue = _prefs.getString(_themeModeKey);
    final themeMode = themeModeStringValue?.toThemeMode ?? ThemeMode.system;
    Cache.instance.setThemeMode(themeMode);

    return themeMode;
  }

  Future<void> resetSession() async {
    await _prefs.remove(_sessionTokenKey);
    await _prefs.remove(_userIdKey);
    Cache.instance.resetSession();
  }

  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;
}

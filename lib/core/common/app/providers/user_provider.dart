import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._internal();

  static final instance = UserProvider._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User? user) {
    if (_currentUser != user) _currentUser = user;
  }

  void updateUser(User user) {
    if (_currentUser != user) _currentUser = user;
    notifyListeners();
  }
}

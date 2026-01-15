import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

extension StringExt on String {
  Map<String, String> get toAuthHeaders {
    return {
      'Authorization': 'Bearer $this',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  ThemeMode get toThemeMode {
    return switch (toLowerCase()) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  String get obscureEmail {
    //here we split the email into username and domain
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    //then I'll covert part of the username to ***,then leave in only the first and last characters
    username = '${username[0]}****${username[username.length - 1]}';
    return '$username@$domain';
  }

  bool get isValidateEmail {
    if (!EmailValidator.validate(trim())) {
      return false;
    }
    return true;
  }

  Color get toColor {
    String hexString = replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF$hexString";
    }
    if (hexString.length == 8) {
      return Color(int.parse(hexString, radix: 16));
    } else {
      throw FormatException("Invalid hex string format: $this");
    }
  }
}

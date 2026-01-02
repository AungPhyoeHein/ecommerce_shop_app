import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';

abstract class CoreUtils {
  const CoreUtils();

  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgoundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgoundColor ?? MyColors.lightThemePrimaryColor,
      content: Text(message, style: TextStyles.paragraphSubTextRegular1.white),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 2000),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color adaptiveColor(
    BuildContext context, {
    required Color lightModeColor,
    required Color darkModeColor,
  }) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkModeColor
        : lightModeColor;
  }
}

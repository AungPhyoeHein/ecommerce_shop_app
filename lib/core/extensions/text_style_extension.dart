import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get orange => copyWith(color: MyColors.lightThemeSecondaryColor);

  TextStyle get dark => copyWith(color: MyColors.lightThemePrimaryTextColor);

  TextStyle get grey => copyWith(color: MyColors.lightThemeSecondaryTextColor);

  TextStyle get white => copyWith(color: MyColors.lightThemeWhiteColor);

  TextStyle get primary => copyWith(color: MyColors.lightThemePrimaryColor);

  TextStyle adaptiveColor(BuildContext context) =>
      copyWith(color: MyColors.classicAdaptiveTextColor(context));
}

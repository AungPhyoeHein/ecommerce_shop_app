import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CoreUtils.adaptiveColor(
        context,
        lightModeColor: MyColors.lightThemeStockColor,
        darkModeColor: MyColors.darkThemeDarkNavBarColor,
      ),
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeStockColor,
          darkModeColor: MyColors.darkThemeDarkNavBarColor,
        ),
      ),
    );
  }
}

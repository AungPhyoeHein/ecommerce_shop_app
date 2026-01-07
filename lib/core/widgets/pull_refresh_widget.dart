import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart'
    hide RefreshCallback;

class PullRefreshWidget extends StatelessWidget {
  const PullRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final RefreshCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: onRefresh,
      height: 100,
      springAnimationDurationInMilliseconds: 1000,

      color: CoreUtils.adaptiveColor(
        context,
        lightModeColor: MyColors.lightThemeStockColor,
        darkModeColor: MyColors.darkThemeDarkNavBarColor,
      ),
      child: child,
    );
  }
}

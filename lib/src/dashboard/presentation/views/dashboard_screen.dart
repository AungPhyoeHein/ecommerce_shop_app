import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/dashboard/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  final selectedIconColor = MyColors.lightThemeWhiteColor;
  final unSelectedIconColor = MyColors.lightThemeSecondaryTextColor;

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/products')) return 1;
    if (location.startsWith('/chat')) return 2;
    if (location.startsWith('/wishlist')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _calculateSelectedIndex(state.uri.path);

    return Scaffold(
      key: DashboardUtils.scaffoldKey,
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        backgroundColor: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeStockColor,
          darkModeColor: MyColors.darkThemeDarkSharpColor,
        ),
        buttonBackgroundColor: MyColors.lightThemePrimaryColor,
        color: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeWhiteColor,
          darkModeColor: MyColors.darkThemeDarkNavBarColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/products');
              break;
            case 2:
              context.go('/chat');
              break;
            case 3:
              context.go('/wishlist');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        items: [
          _buildIcon(
            0,
            currentIndex,
            HugeIconsSolid.home01,
            HugeIconsStroke.home01,
          ),
          _buildIcon(
            1,
            currentIndex,
            HugeIconsSolid.discoverCircle,
            HugeIconsStroke.discoverCircle,
          ),
          _buildIcon(
            2,
            currentIndex,
            HugeIconsSolid.bubbleChat,
            HugeIconsStroke.bubbleChat,
          ),
          _buildIcon(
            3,
            currentIndex,
            HugeIconsSolid.shoppingBagFavorite,
            HugeIconsStroke.shoppingBagFavorite,
          ),
          _buildIcon(
            4,
            currentIndex,
            HugeIconsSolid.user03,
            HugeIconsStroke.user03,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(
    int index,
    int currentIndex,
    IconData solidIcon,
    IconData strokeIcon,
  ) {
    final isSelected = index == currentIndex;
    return Icon(
      isSelected ? solidIcon : strokeIcon,
      color: isSelected ? selectedIconColor : unSelectedIconColor,
      size: 30,
    );
  }
}

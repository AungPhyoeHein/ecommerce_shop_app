import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/src/dashboard/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final selectedIconColor = MyColors.lightThemeWhiteColor;

  final unSelectedIconColor = MyColors.lightThemeSecondaryTextColor;

  // Future<void> _loadProductInitialData() async {
  //   context.read<CategoryCubit>().getCategory(isRefresh: false);

  //   context.read<ProductCubit>().getProducts(page: 1, isRefresh: false);
  // }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = widget.navigationShell.currentIndex;

    return Scaffold(
      key: DashboardUtils.scaffoldKey,
      body: widget.navigationShell,
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
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
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

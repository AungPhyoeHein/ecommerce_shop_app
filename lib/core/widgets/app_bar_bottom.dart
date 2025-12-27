import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ColoredBox(
        color: CoreUtils.adaptiveColor(
          context,
          lightModeColor: Colors.white,
          darkModeColor: MyColors.darkThemeDarkSharpColor,
        ),
        child: const SizedBox(height: 0.1, width: double.maxFinite),
      ),
    );
  }

  @override
  Size get preferredSize => Size.zero;
}

import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CoreUtils.adaptiveColor(
        context,
        lightModeColor: MyColors.lightThemeStockColor,
        darkModeColor: MyColors.darkThemeDarkNavBarColor,
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: CoreUtils.adaptiveColor(
                context,
                lightModeColor: MyColors.lightThemeStockColor,
                darkModeColor: MyColors.darkThemeDarkNavBarColor,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 20,
              backgroundColor: MyColors.lightThemePrimaryTint,
              child: Text(user.name[0], style: TextStyles.appLogo),
            ),
            accountName: Text(
              user.name,
              style: TextStyles.headingMedium3.adaptiveColor(context),
            ),
            accountEmail: Text(
              user.email,
              style: TextStyles.paragraphSubTextRegular.adaptiveColor(context),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Profile',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.profile02,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Edit',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.edit01,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Wishlist',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.favourite,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Orders History',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.transactionHistory,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Privacy Policy',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.securityCheck,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Terms & Conditions',
                    style: TextStyles.headingMedium3.adaptiveColor(context),
                  ),
                  leading: Icon(
                    HugeIconsStroke.documentValidation,
                    color: MyColors.classicAdaptiveTextColor(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RoundedButton(text: "Logout", backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}

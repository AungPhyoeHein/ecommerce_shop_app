import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = UserProvider.instance.currentUser!;
    final adaptiveTextColor = MyColors.classicAdaptiveTextColor(context);
    final drawerBgColor = CoreUtils.adaptiveColor(
      context,
      lightModeColor: MyColors.lightThemeStockColor,
      darkModeColor: MyColors.darkThemeDarkNavBarColor,
    );

    return Drawer(
      backgroundColor: drawerBgColor,
      child: Column(
        children: [
          _UserHeader(user: user, bgColor: drawerBgColor),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _DrawerItem(
                  title: 'Profile',
                  icon: HugeIconsStroke.profile02,
                  color: adaptiveTextColor,
                  onTap: () {
                    // Navigate to Profile
                  },
                ),
                _DrawerItem(
                  title: 'Edit Profile',
                  icon: HugeIconsStroke.edit01,
                  color: adaptiveTextColor,
                  onTap: () {},
                ),
                _DrawerItem(
                  title: 'Wishlist',
                  icon: HugeIconsStroke.favourite,
                  color: adaptiveTextColor,
                  onTap: () {},
                ),
                _DrawerItem(
                  title: 'Orders History',
                  icon: HugeIconsStroke.transactionHistory,
                  color: adaptiveTextColor,
                  onTap: () {},
                ),
                _DrawerItem(
                  title: 'Privacy Policy',
                  icon: HugeIconsStroke.securityCheck,
                  color: adaptiveTextColor,
                  onTap: () {},
                ),
                _DrawerItem(
                  title: 'Terms & Conditions',
                  icon: HugeIconsStroke.documentValidation,
                  color: adaptiveTextColor,
                  onTap: () {},
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: RoundedButton(
              text: "Logout",
              height: 50,
              backgroundColor: Colors.red,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.user, required this.bgColor});

  final User user;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(color: bgColor),
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
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        title,
        style: TextStyles.headingMedium3.adaptiveColor(context),
      ),
    );
  }
}

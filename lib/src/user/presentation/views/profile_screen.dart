import 'package:ecommerce_shop_app/core/common/app/providers/theme_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/locale_provider.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/l10n/app_localizations.dart';
import 'package:ecommerce_shop_app/core/widgets/cart_badge.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_shop_app/src/user/presentation/widgets/profile_header.dart';
import 'package:ecommerce_shop_app/src/user/presentation/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const path = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.adaptiveBackgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          l10n.profile,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.5,
            color: MyColors.classicAdaptiveTextColor(context),
          ),
        ),
        actions: [
          CartBadge(
            child: IconButton(
              onPressed: () => context.push(CartScreen.path),
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: MyColors.classicAdaptiveTextColor(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const ProfileHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context, l10n.accountOverview),
                  _buildMenuCard(context, [
                    ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      subtitle: 'Track, return or buy things again',
                      onTap: () {},
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'Wishlist',
                      subtitle: 'Your favorite items saved here',
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionHeader(context, 'Personal Info'),
                  _buildMenuCard(context, [
                    ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Shipping Address',
                      subtitle: 'Manage your delivery addresses',
                      onTap: () {},
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.payment_rounded,
                      title: l10n.payment,
                      subtitle: 'Cards and payment settings',
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionHeader(context, l10n.settingsAndSupport),
                  _buildMenuCard(context, [
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return ProfileMenuItem(
                          icon: themeProvider.isDarkMode
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          title: l10n.darkMode,
                          subtitle: themeProvider.isDarkMode
                              ? l10n.on
                              : l10n.off,
                          trailing: Switch.adaptive(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                            },
                            activeColor: MyColors.lightThemePrimaryColor,
                          ),
                          onTap: () {
                            themeProvider.toggleTheme();
                          },
                        );
                      },
                    ),
                    const _MenuDivider(),
                    Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) {
                        return ProfileMenuItem(
                          icon: Icons.language_rounded,
                          title: l10n.language,
                          subtitle: _getLanguageName(
                            localeProvider.locale.languageCode,
                          ),
                          onTap: () {
                            _showLanguageBottomSheet(context, localeProvider);
                          },
                        );
                      },
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.notifications_none_rounded,
                      title: l10n.notifications,
                      onTap: () {},
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.security_rounded,
                      title: l10n.security,
                      onTap: () {},
                    ),
                    const _MenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 32),
                  _buildMenuCard(context, [
                    ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      title: l10n.logout,
                      iconColor: Colors.redAccent,
                      textColor: Colors.redAccent,
                      onTap: () {
                        // Logout logic
                      },
                    ),
                  ]),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: MyColors.classicAdaptiveTextColor(context),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.adaptiveCardColor(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.2 : 0.03,
            ),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(children: children),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'my':
        return 'မြန်မာ';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'th':
        return 'ไทย';
      case 'hi':
        return 'हिन्दी';
      case 'en':
      default:
        return 'English';
    }
  }

  void _showLanguageBottomSheet(
    BuildContext context,
    LocaleProvider localeProvider,
  ) {
    final languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'my', 'name': 'မြန်မာ'},
      {'code': 'zh', 'name': '中文'},
      {'code': 'ja', 'name': '日本語'},
      {'code': 'ko', 'name': '한국어'},
      {'code': 'th', 'name': 'ไทย'},
      {'code': 'hi', 'name': 'हिन्दी'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.adaptiveBackgroundColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: MyColors.adaptiveDividerColor(context),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyColors.classicAdaptiveTextColor(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          final lang = languages[index];
                          final isSelected =
                              localeProvider.locale.languageCode ==
                              lang['code'];
                          return ListTile(
                            title: Text(
                              lang['name']!,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? MyColors.lightThemePrimaryColor
                                    : MyColors.classicAdaptiveTextColor(
                                        context,
                                      ),
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: MyColors.lightThemePrimaryColor,
                                  )
                                : null,
                            onTap: () {
                              localeProvider.setLocale(Locale(lang['code']!));
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 56, right: 16),
      child: Divider(
        height: 1,
        color: MyColors.adaptiveDividerColor(context).withOpacity(0.5),
      ),
    );
  }
}

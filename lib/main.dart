import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/theme_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/locale_provider.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/services/injection_container.dart';
import 'package:ecommerce_shop_app/core/services/router.dart';
import 'package:ecommerce_shop_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: MyColors.lightThemePrimaryColor,
      ),
      fontFamily: 'Switzer',
      scaffoldBackgroundColor: MyColors.lightThemeTintStockColour,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.lightThemeTintStockColour,
        foregroundColor: MyColors.lightThemePrimaryTextColor,
      ),
      brightness: Brightness.light,
    );

    final darkTheme = theme.copyWith(
      scaffoldBackgroundColor: MyColors.darkThemeBGDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.darkThemeBGDark,
        foregroundColor: MyColors.lightThemeWhiteColor,
      ),
      brightness: Brightness.dark,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<UserProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => sl<LocaleProvider>()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp.router(
            title: 'ECOMI',
            themeMode: themeProvider.themeMode,
            theme: theme,
            darkTheme: darkTheme,
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

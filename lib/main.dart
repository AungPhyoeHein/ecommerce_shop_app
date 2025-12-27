import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/services/injection_container.dart';
// import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/services/router.dart';
import 'package:flutter/material.dart';

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
    );

    final darkTheme = theme.copyWith(
      scaffoldBackgroundColor: MyColors.darkThemeBGDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.darkThemeBGDark,
        foregroundColor: MyColors.lightThemeWhiteColor,
      ),
    );
    return MaterialApp.router(
      title: 'ECOMI',
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,

      // home: Scaffold(
      //   body: Center(
      //     child: Text(
      //       'Hello World!',
      //       style: TextStyles.headingRegular.copyWith(
      //         color: MyColors.classicAdaptiveTextColor(context),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

import 'package:ecommerce_shop_app/core/common/app/providers/user_provider.dart';
import 'package:ecommerce_shop_app/core/entities/user.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/constants/icon_constants.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/core/widgets/ecomi_logo.dart';
import 'package:ecommerce_shop_app/core/widgets/products_list_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/category_list_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/banner_images_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/search_input_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const path = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadInitialData() async {
    context.read<CategoryCubit>().getCategory();
    context.read<ProductCubit>().getProducts(page: 1, criteria: "popular");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _refreshData() async {
    await _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = UserProvider.instance.currentUser!;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: EcomiLogo(style: TextStyles.headingBold1),
        leading: IconButton(
          icon: SvgIcon(IconConstants.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgIcon(IconConstants.shoppingCart),
          ),
          IconButton(onPressed: () {}, icon: SvgIcon(IconConstants.qrScan)),
        ],
        bottom: AppBarBottom(),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refreshData,
        height: 100,
        springAnimationDurationInMilliseconds: 1000,

        color: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeStockColor,
          darkModeColor: MyColors.darkThemeDarkNavBarColor,
        ),
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),

          children: [
            SearchInputWidget(),
            const Gap(20),
            BannerImagesWidget(),
            const Gap(20),
            CategoryListWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Products',
                  style: TextStyles.headingBold1.adaptiveColor(context),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyles.paragraphSubTextRegular3,
                  ),
                ),
              ],
            ),
            ProductsListWidget(),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.lightThemeStockColor,
          darkModeColor: MyColors.darkThemeDarkNavBarColor,
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 20,
                backgroundColor: MyColors.lightThemePrimaryTint,
                child: Text(user.name[0], style: TextStyles.appLogo),
              ),
              accountName: Text(
                user.name,
                style: TextStyles.headingMedium3.adaptiveColor(context),
              ),
              accountEmail: Text(user.email),
            ),
            Expanded(
              child: ListView(
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
            RoundedButton(text: "Logout"),
          ],
        ),
      ),
    );
  }
}

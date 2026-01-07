import 'package:ecommerce_shop_app/core/common/app/providers/popular_product_provider.dart';
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
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/category_list_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/banner_images_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/home_drawer_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/search_input_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const path = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final _popularProductProvider = PopularProductProvider.instance;

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
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refreshData() async {
    _popularProductProvider.clearPopularProductList();
    await _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final state = context.read<ProductCubit>().state;

      if (state is! ProductLoading && !_popularProductProvider.isEnd) {
        context.read<ProductCubit>().getProducts(
          page: _popularProductProvider.currentPage,
          criteria: "popular",
        );
      }
    }
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
          physics: AlwaysScrollableScrollPhysics(),
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
            Selector<PopularProductProvider, bool>(
              selector: (context, provider) => provider.isEnd,
              builder: (context, isEnd, child) {
                if (isEnd) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    alignment: Alignment.center,
                    child: Text(
                      "There is no more popular product",
                      style: TextStyles.paragraphSubTextRegular3.grey,
                    ),
                  );
                }
                return SizedBox(height: 50);
              },
            ),
          ],
        ),
      ),
      drawer: HomeDrawerWidget(user),
    );
  }
}

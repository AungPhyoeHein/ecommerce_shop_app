import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/constants/icon_constants.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/core/widgets/ecomi_logo.dart';
import 'package:ecommerce_shop_app/core/widgets/products_list_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/pull_refresh_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/svg_icon.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/category_list_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/banner_images_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/drawer_widget.dart';
import 'package:ecommerce_shop_app/src/home/presentation/widgets/search_input_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
    context.read<CategoryCubit>().getCategory(isRefresh: false);

    context.read<ProductCubit>().getProducts(
      page: 1,
      criteria: "popular",
      isRefresh: false,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refreshData() async {
    context.read<CategoryCubit>().getCategory(isRefresh: true);
    context.read<ProductCubit>().getProducts(
      page: 1,
      criteria: "popular",
      isRefresh: true,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = context.read<ProductCubit>().state;

      if (state is GotProducts && !state.isEnd) {
        context.read<ProductCubit>().getProducts(
          page: state.page + 1,
          criteria: "popular",
          isRefresh: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadInitialData();
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
      body: PullRefreshWidget(
        onRefresh: _refreshData,
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
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is GotProducts) {
                  if (state.isEnd) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: Text(
                        "There is no more popular product",
                        style: TextStyles.paragraphSubTextRegular3.grey,
                      ),
                    );
                  }
                }
                return SizedBox(height: 50);
              },
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}

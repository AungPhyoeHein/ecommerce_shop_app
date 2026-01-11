import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/products_list_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/pull_refresh_widget.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/widgets/categories_select_button_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  static const path = "/products";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadInitialData({bool isRefresh = false}) async {
    context.read<CategoryCubit>().getCategory(isRefresh: isRefresh);
    context.read<ProductCubit>().getProducts(page: 1, isRefresh: isRefresh);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refreshData() async {
    await _loadInitialData(isRefresh: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<ProductCubit>().state;

    if (state is! ProductLoading && state is! NextProductsLoading) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        if (state is GotFilteredProducts && !state.isEnd) {
          context.read<ProductCubit>().getProducts(
            page: state.page + 1,
            category: state.selectedCategory,
            isRefresh: false,
          );
        } else if (state is GotProducts && !state.isEnd) {
          context.read<ProductCubit>().getProducts(
            page: state.page + 1,
            isRefresh: false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadInitialData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Discover Product', style: TextStyles.headingMedium3),
      ),
      body: PullRefreshWidget(
        onRefresh: _refreshData,
        child: ListView(
          key: const PageStorageKey('discover_product_list_key'),
          controller: _scrollController,
          cacheExtent: 1500,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          children: [
            const CategoriesSelectButtonGroup(),
            const Gap(20),
            const ProductsListWidget(),
            const _PaginationStatus(),
          ],
        ),
      ),
    );
  }
}

class _PaginationStatus extends StatelessWidget {
  const _PaginationStatus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return loadingOfProduct();
        }
        if (state is GotProducts && state.isEnd && state.products.isNotEmpty) {
          return endOfProduct();
        }
        return const SizedBox(height: 50);
      },
    );
  }
}

Widget endOfProduct() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 40),
    alignment: Alignment.center,
    child: Text(
      "There is no more product",
      style: TextStyles.paragraphSubTextRegular3.grey,
    ),
  );
}

Widget loadingOfProduct() {
  return SizedBox(height: 50);
}

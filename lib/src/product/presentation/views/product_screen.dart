import 'package:ecommerce_shop_app/core/common/app/providers/filter_product_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/products_provider.dart';
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
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  static const path = "/products";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final _productProvider = ProductsProvider.instance;
  final _filterProductProvider = FilterProductProvider.instance;

  Future<void> _loadInitialData({bool isRefresh = false}) async {
    context.read<CategoryCubit>().getCategory(isRefresh: isRefresh);
    if (_filterProductProvider.category == null) {
      context.read<ProductCubit>().getProducts(page: 1);
    } else {
      context.read<ProductCubit>().searchProducts(
        page: _filterProductProvider.currentPage,
        category: _filterProductProvider.category,
      );
    }
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
    await _loadInitialData(isRefresh: true);
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

      if (state is ProductLoading) return;

      if (_filterProductProvider.category == null) {
        if (!_productProvider.isEnd) {
          context.read<ProductCubit>().getProducts(
            page: _productProvider.currentPage + 1,
          );
        }
      } else {
        if (!_filterProductProvider.isEnd) {
          context.read<ProductCubit>().searchProducts(
            page: _filterProductProvider.currentPage + 1,
            category: _filterProductProvider.category!,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Discover Product', style: TextStyles.headingMedium3),
      ),
      body: PullRefreshWidget(
        onRefresh: _refreshData,
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          children: [
            CategoriesSelectButtonGroup(),
            Gap(20),
            ProductsListWidget(),
            _PaginationStatus(),
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
    final filterProvider = context.watch<FilterProductProvider>();
    final productProvider = context.watch<ProductsProvider>();

    final bool isFiltered = filterProvider.category != null;
    final bool isEnd = isFiltered
        ? filterProvider.isEnd
        : productProvider.isEnd;

    if (isEnd) {
      return endOfProduct();
    }

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return loadingOfProduct();
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

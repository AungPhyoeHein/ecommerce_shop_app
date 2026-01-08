import 'package:ecommerce_shop_app/core/common/app/providers/filter_product_provider.dart';
import 'package:ecommerce_shop_app/core/common/app/providers/products_provider.dart';
import 'package:ecommerce_shop_app/core/entities/category.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

const _height = 90.0;

class CategoriesSelectButtonGroup extends StatefulWidget {
  const CategoriesSelectButtonGroup({super.key});

  @override
  State<CategoriesSelectButtonGroup> createState() =>
      _CategoriesSelectButtonGroupState();
}

class _CategoriesSelectButtonGroupState
    extends State<CategoriesSelectButtonGroup> {
  final _filterProductsProvider = FilterProductProvider.instance;
  final _productsProvider = ProductsProvider.instance;

  void _onSelectedCategory(Category category) {
    context.read<ProductCubit>().searchProducts(page: 1, category: category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (BuildContext context, state) {
        if (state is GotCategories) {
          if (state.categories.isEmpty) {
            return SizedBox(
              height: _height,
              child: Center(
                child: Center(
                  child: Text(
                    "Category is Empty.",
                    style: TextStyles.paragraphRegular.adaptiveColor(context),
                  ),
                ),
              ),
            );
          }
          return GroupButton(
            controller: GroupButtonController(
              selectedIndex: _filterProductsProvider.category != null
                  ? state.categories.indexWhere(
                          (category) =>
                              category.id == _filterProductsProvider.category,
                        ) +
                        1
                  : 0,
            ),
            options: GroupButtonOptions(
              borderRadius: BorderRadius.circular(10),
              mainGroupAlignment: MainGroupAlignment.start,
            ),

            onSelected: (value, index, isSelected) {
              if (isSelected == true) {
                if (index <= 0) {
                  _filterProductsProvider.clearFilterProductList();
                  return context.read<ProductCubit>().getProducts(
                    page: _productsProvider.currentPage,
                  );
                }
                _onSelectedCategory(state.categories[index - 1]);
              }
            },
            buttons: [
              'All',
              ...state.categories.map((category) => category.name).toList(),
            ],
          );
        }

        return SizedBox(
          height: _height,
          child: Center(
            child: Text(
              "Unknown Error",
              style: TextStyles.paragraphRegular.adaptiveColor(context),
            ),
          ),
        );
      },
    );
  }
}

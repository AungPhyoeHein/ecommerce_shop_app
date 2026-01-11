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
  void _onSelectedCategory(Category category) {
    context.read<ProductCubit>().getProducts(
      page: 1,
      category: category.id,
      isRefresh: true,
    );
  }

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productState = context.watch<ProductCubit>().state;

    return BlocConsumer<CategoryCubit, CategoryState>(
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
          } else if (state is CategoryLoading) {
            return SizedBox(
              height: _height,
              child: Center(
                child: Text(
                  "Loading Categories...",
                  style: TextStyles.paragraphRegular.adaptiveColor(context),
                ),
              ),
            );
          }
          return GroupButton(
            controller: GroupButtonController(
              selectedIndex: () {
                if (productState is GotFilteredProducts) {
                  final index = state.categories.indexWhere(
                    (category) => category.id == productState.selectedCategory,
                  );
                  return index != -1 ? index + 1 : 0;
                }
                return _selectedCategoryIndex;
              }(),
            ),
            options: GroupButtonOptions(
              borderRadius: BorderRadius.circular(10),
              mainGroupAlignment: MainGroupAlignment.start,
            ),

            onSelected: (value, index, isSelected) {
              if (isSelected == true) {
                _selectedCategoryIndex = index;
                if (index == 0) {
                  if (productState is GotProducts) {
                    return context.read<ProductCubit>().getProducts(
                      page: productState.page,
                      isRefresh: false,
                    );
                  }
                }
                _onSelectedCategory(state.categories[index - 1]);
              }
            },
            buttons: [
              'All',
              ...state.categories.map((category) => category.name),
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
      listener: (BuildContext context, CategoryState state) {
        if (state is CategoryLoading) {
          _selectedCategoryIndex = 0;
        }
      },
    );
  }
}

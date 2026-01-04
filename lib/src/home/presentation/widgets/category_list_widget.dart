import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/category/category_item.dart';
import 'package:ecommerce_shop_app/core/widgets/category/category_shimmer_item.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _height = 90.0;
const _shimmerCount = 5;

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
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
          return _CategoryList(state: state);
        }

        if (state is CategoryLoading) {
          return _CategoryList(state: null);
        }

        return SizedBox(
          height: _height,
          child: Center(
            child: Text(
              "Error When Featch",
              style: TextStyles.headingBold3.adaptiveColor(context),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({this.state});

  final GotCategories? state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state != null ? state!.categories.length : _shimmerCount,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (_, index) {
          return state != null
              ? CategoryItem(category: state!.categories[index])
              : const CategoryShimmerItem();
        },
      ),
    );
  }
}

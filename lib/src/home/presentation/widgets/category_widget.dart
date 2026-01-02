import 'package:ecommerce_shop_app/core/widgets/category_item.dart';
import 'package:ecommerce_shop_app/core/widgets/category_loading_widget.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GotCategories) {
          return SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemBuilder: (ctx, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CategoryItem(category: state.categories[index])],
                );
              },
            ),
          );
        } else if (state is CategoryLoading) {
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemBuilder: (ctx, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CategoryLoadingWidget()],
                );
              },
            ),
          );
        }
        return const SizedBox(height: 90);
      },
    );
  }
}

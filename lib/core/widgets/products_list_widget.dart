import 'package:ecommerce_shop_app/core/widgets/product/product_card.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_not_found_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_shimmer_card.dart';
import 'package:ecommerce_shop_app/core/widgets/something_was_wrong_widget.dart';
import 'package:ecommerce_shop_app/src/product/presentation/app/adapter/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _shimmerItemCount = 4;

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 9 / 14,
            ),
            itemBuilder: (context, index) {
              return const ProductShimmerCard();
            },
          );
        }
        if (state is GotProducts) {
          if (state.products.isEmpty) {
            return const ProductNotFoundWidget();
          }
          return _productList(state);
        }
        return SizedBox(height: 300, child: SomethingWasWrongWidget());
      },
    );
  }
}

Widget _productList(GotProducts? state) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 0),
    itemCount: state is GotProducts ? state.products.length : _shimmerItemCount,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 250,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 0.58,
    ),
    itemBuilder: (context, index) {
      return state is GotProducts
          ? ProductCard(state.products[index])
          : const ProductShimmerCard();
    },
  );
}

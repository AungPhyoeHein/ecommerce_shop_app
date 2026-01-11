import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card_colors.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card_image.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card_info.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card_rating.dart';
import 'package:ecommerce_shop_app/src/product/presentation/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final String hero = GoRouterState.of(context).uri.toString() + product.id;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;

        final imageHeight = cardWidth;
        final gapSize = cardWidth * 0.02;
        final ratingIconSize = cardWidth < 170 ? 20.0 : 20.0;
        return GestureDetector(
          onTap: () {
            context.push(
              '${ProductDetailScreen.path}${product.id}',
              extra: {
                "id": product.id,
                "name": product.name,
                "image": product.image,
                "hero": hero,
              },
            );
          },
          child: Card(
            color: CoreUtils.adaptiveColor(
              context,
              lightModeColor: MyColors.lightThemeStockColor,
              darkModeColor: MyColors.darkThemeDarkNavBarColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(cardWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: ProductCardImage(product, hero),
                  ),
                  SizedBox(height: gapSize),
                  ProductCardInfo(product, cardWidth: cardWidth),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductCardRating(
                        product.rating,
                        iconSize: ratingIconSize,
                      ),
                      if (product.colors.isNotEmpty)
                        ProductCardColors(
                          product.colors,
                          radius: cardWidth < 170
                              ? cardWidth < 140
                                    ? cardWidth < 133
                                          ? 3
                                          : 4
                                    : 6
                              : 8,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

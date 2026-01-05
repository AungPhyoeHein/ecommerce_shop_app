import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';

class ProductCardInfo extends StatelessWidget {
  const ProductCardInfo(this.product, {super.key, required this.cardWidth});

  final Product product;
  final double cardWidth;

  TextStyle get nameStyle => cardWidth < 160
      ? TextStyles.paragraphSubTextRegular.copyWith(fontWeight: FontWeight.bold)
      : TextStyles.paragraphSubTextRegular3.copyWith(
          fontWeight: FontWeight.bold,
        );

  TextStyle get priceStyle => cardWidth < 160
      ? TextStyles.paragraphSubTextRegular3
            .copyWith(fontWeight: FontWeight.bold)
            .orange
      : TextStyles.headingSemiBold1.orange;

  TextStyle get descStyle => cardWidth < 160
      ? TextStyles.paragraphSubTextRegular.copyWith(fontSize: 10).grey
      : TextStyles.paragraphSubTextRegular.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: nameStyle.adaptiveColor(context),
        ),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          maxLines: 1,
          style: priceStyle,
        ),
        Text(
          product.description,
          maxLines: cardWidth < 170
              ? 1
              : cardWidth > 200
              ? 3
              : 2,
          overflow: TextOverflow.ellipsis,
          style: descStyle.adaptiveColor(context),
        ),
      ],
    );
  }
}

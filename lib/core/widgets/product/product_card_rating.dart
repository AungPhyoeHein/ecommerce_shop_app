import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';

class ProductCardRating extends StatelessWidget {
  const ProductCardRating(this.rating, {this.iconSize = 16, super.key});

  final double rating;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber, size: iconSize),
        SizedBox(width: iconSize * 0.3),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: iconSize * 0.7,
            color: MyColors.classicAdaptiveTextColor(context),
          ),
        ),
      ],
    );
  }
}

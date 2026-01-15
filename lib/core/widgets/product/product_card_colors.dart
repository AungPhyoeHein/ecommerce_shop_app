import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';

class ProductCardColors extends StatelessWidget {
  const ProductCardColors(this.colors, {this.radius = 10, super.key});

  final List<String> colors;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: MyColors.lightThemeSecondaryTextColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        children: [
          ...colors
              .take(3)
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: color.toColor,
                  ),
                ),
              ),
          if (colors.length > 3)
            Text(
              " +${colors.length - 3}",
              style: TextStyle(
                fontSize: radius + 1.2,
                color: MyColors.lightThemeSecondaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

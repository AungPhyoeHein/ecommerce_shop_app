import 'package:ecommerce_shop_app/core/extensions/widget_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons_pro/hugeicons.dart';

class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.isOutOfStock = false,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutOfStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: RoundedButton(
          text: isOutOfStock ? "Out of Stock" : "Add to Cart",
          height: 55,
          onPressed: isOutOfStock ? () {} : onPressed,
          backgroundColor: isOutOfStock
              ? Colors.grey
              : MyColors.lightThemePrimaryColor,
          // icon: isOutOfStock ? null : const Icon(
          //   HugeIconsStroke.shoppingCart01,
          //   color: Colors.white,
          //   size: 20,
          // ),
        ).loading(isLoading),
      ),
    );
  }
}

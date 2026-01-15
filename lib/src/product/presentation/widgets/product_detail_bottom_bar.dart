import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RoundedButton(text: "Add to Cart", height: 50),
    );
  }
}

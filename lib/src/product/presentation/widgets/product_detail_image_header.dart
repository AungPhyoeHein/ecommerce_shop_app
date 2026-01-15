import 'package:ecommerce_shop_app/src/product/presentation/widgets/product_image_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailImageHeader extends StatelessWidget {
  const ProductDetailImageHeader({
    super.key,
    required this.hero,
    required this.images,
  });

  final String hero;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Hero(
        tag: hero,
        child: ProductImageSlider(images: images),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:ecommerce_shop_app/core/widgets/error_image_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/shimmer_image_loading_widget.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  const ProductCardImage(this.product, this.hero, {super.key});
  final Product product;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          Hero(
            tag: hero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const ShimmerImageLoadingWidget(),
                errorWidget: (context, error, stackTrace) =>
                    const ErrorImageWidget(),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white.withOpacity(0.7),
                child: const Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

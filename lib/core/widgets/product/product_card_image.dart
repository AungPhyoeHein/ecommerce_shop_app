import 'package:ecommerce_shop_app/core/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // 👈 Shimmer ကို import လုပ်ပါ

class ProductCardImage extends StatelessWidget {
  const ProductCardImage(this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _shimmerImageLoading();
              },
              errorBuilder: (context, error, stackTrace) {
                return _errorImageWidget();
              },
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

Widget _shimmerImageLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    ),
  );
}

Widget _errorImageWidget() {
  return Container(
    color: Colors.grey.shade200,
    child: const Center(
      child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 30),
    ),
  );
}

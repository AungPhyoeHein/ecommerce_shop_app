import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerCard extends StatelessWidget {
  const ProductShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CoreUtils.adaptiveColor(
        context,
        lightModeColor: Colors.grey.shade300,
        darkModeColor: Colors.grey.shade800,
      ),
      highlightColor: CoreUtils.adaptiveColor(
        context,
        lightModeColor: Colors.grey.shade100,
        darkModeColor: Colors.grey.shade500,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 15, width: 100, color: Colors.white),
          const SizedBox(height: 5),
          // Price Placeholder
          Container(height: 15, width: 60, color: Colors.white),
        ],
      ),
    );
  }
}

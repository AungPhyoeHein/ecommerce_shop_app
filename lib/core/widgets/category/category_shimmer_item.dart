import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerItem extends StatelessWidget {
  const CategoryShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Shimmer.fromColors(
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
          child: CircleAvatar(radius: 25, backgroundColor: Colors.white),
        ),
        const SizedBox(height: 5),
        Shimmer.fromColors(
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
          child: Container(height: 10, width: 30, color: Colors.white),
        ),
      ],
    );
  }
}

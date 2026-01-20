import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewShimmerLoadingWidget extends StatelessWidget {
  const ReviewShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: Shimmer.fromColors(
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
        child: const CircleAvatar(radius: 20, backgroundColor: Colors.white),
      ),
      title: Shimmer.fromColors(
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
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      minTileHeight: 50,
      trailing: const SizedBox(width: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    );
  }
}

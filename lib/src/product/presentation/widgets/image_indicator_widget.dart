import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/widgets/error_image_widget.dart';
import 'package:ecommerce_shop_app/core/widgets/shimmer_image_loading_widget.dart';
import 'package:flutter/material.dart';

class ImageIndicatorWidget extends StatelessWidget {
  const ImageIndicatorWidget(this.image, {super.key, required this.isActive});

  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: isActive
              ? MyColors.lightThemeSecondaryColor
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const ShimmerImageLoadingWidget(),
          errorWidget: (context, error, stackTrace) {
            return const ErrorImageWidget();
          },
        ),
      ),
    );
  }
}

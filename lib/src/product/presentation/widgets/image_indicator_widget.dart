import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';

class ImageIndicatorWidget extends StatelessWidget {
  const ImageIndicatorWidget(this.image, {super.key, required this.isActive});

  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
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
        child: Image.network(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

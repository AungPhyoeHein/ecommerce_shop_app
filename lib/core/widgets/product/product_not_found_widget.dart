import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/constants/lottie_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductNotFoundWidget extends StatelessWidget {
  const ProductNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(LottieConstants.emptyBox, height: 180, width: 180),
            Text(
              'No Products Found',
              style: TextStyles.headingSemiBold1.adaptiveColor(context),
            ),
          ],
        ),
      ),
    );
  }
}

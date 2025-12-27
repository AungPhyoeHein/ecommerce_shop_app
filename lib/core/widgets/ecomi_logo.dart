import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';

class EcomiLogo extends StatelessWidget {
  const EcomiLogo({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Eco',
        style: style ?? TextStyles.appLogo.white,
        children: const [
          TextSpan(
            text: 'MI',
            style: TextStyle(color: MyColors.lightThemeSecondaryColor),
          ),
        ],
      ),
    );
  }
}

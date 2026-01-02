import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.title, {super.key, this.size = 20, this.color});

  final String title;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$title.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? MyColors.classicAdaptiveTextColor(context),
        BlendMode.srcIn,
      ),
    );
  }
}

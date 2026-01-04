import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.path, {super.key, this.size = 20, this.color});

  final String path;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? MyColors.classicAdaptiveTextColor(context),
        BlendMode.srcIn,
      ),
    );
  }
}

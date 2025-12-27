import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height,
    this.padding,
    this.textStyle,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 66,
      width: double.maxFinite,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: backgroundColor,
          padding: padding,
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed?.call();
        },
        child: Text(
          text,
          style: textStyle ?? TextStyles.buttonTextHeadingBold.white,
        ),
      ),
    );
  }
}

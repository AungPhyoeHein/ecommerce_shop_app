import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/styles/text.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.defaultValidation = true,
    this.enabled = true,
    this.readOnly = false,
    this.expendable = false,
    this.suffixIconConstraints,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatter,
    this.prefix,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
  });

  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool expendable;
  final BoxConstraints? suffixIconConstraints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: expendable ? 5 : 1,
      minLines: expendable ? 1 : null,
      style: TextStyles.paragraphSubTextRegular3.adaptiveColor(context),
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.theme.primaryColor),
        ),
        hintText:hintText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        hintStyle: TextStyles.paragraphSubTextRegular3.grey,
        suffixIconColor: MyColors.lightThemeSecondaryColor,
        prefix: prefix,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        filled: true,
        fillColor: CoreUtils.adaptiveColor(context, lightModeColor: MyColors.darkThemeDarkSharpColor, darkModeColor: MyColors.lightThemeStockColor)
      ),
      inputFormatters: inputFormatter,
      validator: defaultValidation ? (value){
        if(value == null || value.isEmpty) return 'Required Field';
        return validator?.call(value);
      } : validator,
    );
  }
}

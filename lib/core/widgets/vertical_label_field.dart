import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../res/styles/text.dart';

class VerticalLabelField extends StatelessWidget {
  const VerticalLabelField(
    this.label, {
    super.key,
    required this.controller,
    this.obscureText = false,
    this.defaultValidation = true,
    this.enabled = true,
    this.readOnly = false,
    this.expendable = false,
    this.mainFieldFlex = 1,
    this.prefixFlex = 1,

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
  final String label;
  final int mainFieldFlex;
  final int prefixFlex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsGeometry.fromLTRB(8, 0, 0, 0),
          child: Text(
            label,
            style: TextStyles.headingMedium4.adaptiveColor(context),
          ),
        ),
        const Gap(10),
        Row(
          children: [
            if (prefix != null) ...[
              Expanded(flex: prefixFlex, child: prefix!),
              const Gap(8),
            ],
            Expanded(
              flex: mainFieldFlex,
              child: InputField(
                controller: controller,
                focusNode: focusNode,
                suffixIcon: suffixIcon,
                hintText: hintText,
                validator: validator,
                keyboardType: keyboardType,
                obscureText: obscureText,
                defaultValidation: defaultValidation,
                inputFormatter: inputFormatter,
                enabled: enabled,
                readOnly: readOnly,
                onTap: onTap,
                contentPadding: contentPadding,
                expendable: expendable,
                prefixIcon: prefixIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPField extends StatelessWidget {
  const OTPField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autoFocus: true,
      appContext: context,
      length: 4,
      dialogConfig: DialogConfig(
        dialogContent: 'Do you want to paste',
        dialogTitle: 'Paste OTP',
      ),
      textStyle: TextStyles.headingMedium1.copyWith(
        fontWeight: FontWeight.bold,
        color: MyColors.classicAdaptiveTextColor(context),
      ),
      pinTheme: PinTheme(
        inactiveColor: Color(0xFFEEEEEE),
        selectedColor: context.theme.primaryColor,
        activeColor: context.theme.primaryColor,
        shape: PinCodeFieldShape.box,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 52,
        fieldWidth: 70,
        activeFillColor: const Color(0xFFFAFBFA),
        inactiveFillColor: const Color(0xFFFAFBFA),
      ),
      onChanged: (value) {},
      onCompleted: (pin) => controller.text = pin,
      beforeTextPaste: (text) {
        return text != null &&
            text.isNotEmpty &&
            text.length == 4 &&
            int.tryParse(text) != null;
      },
    );
  }
}

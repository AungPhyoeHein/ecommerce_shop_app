import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/widget_extension.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/reset_password_screen.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/o_t_p_field.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/o_t_p_timer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  static const path = '/verify-otp';
  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP", style: TextStyles.headingSemiBold),
        bottom: const AppBarBottom(),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width > 500 ? 500 : double.infinity,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  children: [
                    Text(
                      'Verification Code',
                      style: TextStyles.headingBold3.adaptiveColor(context),
                    ),
                    Text(
                      'Code has been sent to ${widget.email.obscureEmail}',
                      style: TextStyles.paragraphSubTextRegular1.grey,
                    ),
                    const Gap(20),
                    OTPField(controller: _otpController),
                    const Gap(30),
                    OTPTimer(email: widget.email),
                    const Gap(20),
                    RoundedButton(
                      text: 'Verify',
                      onPressed: () {
                        if (_otpController.text.length < 4) {
                          CoreUtils.showSnackBar(
                            context,
                            message: 'Invalid OTP',
                          );
                        } else {
                          context.push(
                            ResetPasswordScreen.path,
                            extra: widget.email,
                          );
                          //TODO(Verify-OTP): Implement OTP Verification
                        }
                      },
                    ).loading(false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

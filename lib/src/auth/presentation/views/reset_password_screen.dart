import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  static const path = '/reset-password';

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyles.headingSemiBold),
        bottom: AppBarBottom(),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width > 500 ? 500 : context.width,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Reset Your Password',
                      style: TextStyles.headingBold3.adaptiveColor(context),
                    ),
                    Text(
                      'Reset your account password with new one.',
                      style: TextStyles.paragraphSubTextRegular1.grey,
                    ),
                    const Gap(40),
                    ResetPasswordForm(email: email),
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

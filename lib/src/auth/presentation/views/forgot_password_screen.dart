import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/res/styles/text.dart';
import '../../../../core/widgets/app_bar_bottom.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const path = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password', style: TextStyles.headingSemiBold),
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
                    vertical: 16,
                    horizontal: 30,
                  ),
                  children: [
                    Text(
                      'Confirm Email',
                      style: TextStyles.headingBold3.adaptiveColor(context),
                    ),
                    Text('Enter the email address associated with your account.',style: TextStyles.paragraphSubTextRegular1.grey,),
                    const Gap(40),
                    const ForgotPasswordForm()
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

import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/registration_screen.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/res/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyles.headingSemiBold),
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
                      'Hello!!',
                      style: TextStyles.headingBold3.adaptiveColor(context),
                    ),
                    Text(
                      'Sign in with your account details',
                      style: TextStyles.paragraphSubTextRegular1.grey,
                    ),
                    const Gap(40),
                    LoginForm(),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an acount? ',
                  style: TextStyles.paragraphSubTextRegular3.grey,
                  children: [
                    TextSpan(
                      text: 'Create Account',
                      style: const TextStyle(
                        color: MyColors.lightThemePrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(RegistrationScreen.path);
                        },
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

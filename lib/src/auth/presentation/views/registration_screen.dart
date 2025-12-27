import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/app_bar_bottom.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/login_screen.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/widgets/registration_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/res/styles/colors.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const path = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyles.headingSemiBold),
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
                      'Create an Account',
                      style: TextStyles.headingBold3.adaptiveColor(context),
                    ),
                    Text(
                      'Create a new Ecomi account',
                      style: TextStyles.paragraphSubTextRegular1.grey,
                    ),
                    const Gap(40),
                    RegistrationForm(),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Do you have an account? ',
                  style: TextStyles.paragraphSubTextRegular3.grey,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: MyColors.lightThemePrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(LoginScreen.path);
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

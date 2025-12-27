import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/widget_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/core/widgets/vertical_label_field.dart';
import 'package:ecommerce_shop_app/src/auth/presentation/views/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obsecurePasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obsecurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          VerticalLabelField(
            'Email',
            controller: emailController,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            defaultValidation: false,
            validator: (value) {
              if (value == null || value == '' || value.isEmpty) {
                return "Required Field.";
              }
              if (!value.isValidateEmail) {
                return "Invalid Email";
              }
              return null;
            },
          ),
          const Gap(20),
          ValueListenableBuilder(
            valueListenable: obsecurePasswordNotifier,
            builder: (context, obscurePassword, child) {
              return VerticalLabelField(
                'Password',
                controller: passwordController,
                hintText: 'Enter your password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    obsecurePasswordNotifier.value =
                        !obsecurePasswordNotifier.value;
                  },
                  child: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyColors.lightThemePrimaryTint,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          SizedBox(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  context.push(ForgotPasswordScreen.path);
                },
                child: Text(
                  'ForgotPassword?',
                  style: TextStyles.paragraphSubTextRegular1.primary,
                ),
              ),
            ),
          ),
          const Gap(40),
          RoundedButton(
            text: 'Sign In',
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ).loading(false),
        ],
      ),
    );
  }
}

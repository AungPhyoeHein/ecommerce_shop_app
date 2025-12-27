import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/core/widgets/vertical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obsecureNewPasswordNotifier = ValueNotifier(true);
  final obsecureConfirmPasswordNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: obsecureNewPasswordNotifier,
            builder: (context, obscurePassword, child) {
              return VerticalLabelField(
                'Change Password',
                controller: newPasswordController,
                hintText: 'Pick your new secure password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    obsecureNewPasswordNotifier.value =
                        !obsecureNewPasswordNotifier.value;
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
          ValueListenableBuilder(
            valueListenable: obsecureConfirmPasswordNotifier,
            builder: (context, obscureConfirmPassword, child) {
              return VerticalLabelField(
                'Confirm Password',
                controller: confirmPasswordController,
                hintText: 'Re-enter your password.',
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscureConfirmPassword,
                validator: (value) {
                  if (value! != newPasswordController.text.trim()) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    obsecureConfirmPasswordNotifier.value =
                        !obsecureConfirmPasswordNotifier.value;
                  },
                  child: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyColors.lightThemePrimaryTint,
                  ),
                ),
              );
            },
          ),
          Gap(40),
          RoundedButton(
            text: "Submit",
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ),
        ],
      ),
    );
  }
}
